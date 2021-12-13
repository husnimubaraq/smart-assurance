import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/info_app/info_app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import 'auth_state.dart';

class AuthController extends GetxController {
  var mainController = Get.put(MainController());
  var dashboardController = Get.put(DashboardController());
  final _authStateStream = AuthState().obs;

  AuthState get state => _authStateStream.value;

  @override
  void onInit() {
    getAuthenticatedUser();
    super.onInit();
    initFcm();
  }

  void setToken(String? token) async {
    print(token);
    Store.saveToken(token!);
  }

  Future<void> initFcm() async {
    String? sessionId = await Store.getSessionId();

    FirebaseMessaging.instance.getToken().then(setToken);

    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   print("message2: ${message}");
    //   if (message is RemoteMessage) {
    //     if (sessionId != null) {
    //       Get.toNamed(Routes.DETAIL_NOTIFICATION,
    //           arguments: message.data["id"]);
    //     }
    //   }
    // });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message1');
      dashboardController.fetchData('');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        Get.snackbar(notification.title!, notification.body!,
            colorText: kWhiteColor,
            duration: Duration(seconds: 5),
            icon: Icon(
              Icons.notifications_active_rounded,
              color: kWhiteColor,
            ),
            backgroundColor: kWarningColor, onTap: (msg) {
          if (message is RemoteMessage) {
            if (sessionId != null) {
              Get.toNamed(Routes.DETAIL_NOTIFICATION,
                  arguments: message.data["id"]);
            }
          }
        });
        if (message is RemoteMessage) {
          if (sessionId != null) {
            // Get.toNamed(Routes.DETAIL_NOTIFICATION, arguments: message.data["id"]);
          }
        }
      }

      // if (notification != null) {
      //   Get.snackbar(notification.title!, notification.body!);
      //   // flutterLocalNotificationsPlugin.show(
      //   //     notification.hashCode,
      //   //     notification.title,
      //   //     notification.body,
      //   //     NotificationDetails(
      //   //       android: AndroidNotificationDetails(
      //   //         channel.id,
      //   //         channel.name,
      //   //         subText: channel.description,
      //   //         // TODO add a proper drawable resource to android, for now using
      //   //         //      one that already exists in example app.
      //   //         // icon: 'launch_background',
      //   //         icon: android?.smallIcon,
      //   //       ),
      //   //     ));
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) async {
    String? sessionId = await Store.getSessionId();
    print('message3: ');
    if (message is RemoteMessage) {
      if (sessionId != null) {
        Get.toNamed(Routes.DETAIL_NOTIFICATION, arguments: message.data["id"]);
      }
    }
  }

  Future<ProviderException> requestLogin(Map<String, String> body) async {
    var response = await UserProvider().requestLogin(body);

    if (response is ProviderException) {
      return response;
    } else {
      String sessionId = "";
      var user = null;
      if (response is UserAdminResponse) {
        mainController.dashboardAdmin.value = response.dashboard!;
        mainController.users.value = response.dashboard!.users;

        dashboardController.usersTeknisi.value =
            response.dashboard!.users!.lists!;

        sessionId = response.sessionId!;
        user = response.user;
      } else if (response is UserRocLeaderResponse) {
        mainController.idleUsers.value =
            response.dashboard!.idleUsers is List<User>
                ? response.dashboard!.idleUsers
                : [];
        mainController.dashboardRocLeader.value = response.dashboard!;

        sessionId = response.sessionId!;
        user = response.user;

        mainController.notifActiveRoc.value =
            response.dashboard!.notifications!.totalUnread!;
      } else if (response is UserTeknisiResponse) {
        mainController.dashboardTeknisi.value = response.dashboard!;
        ;
        mainController.cronjobLogLocationTime.value =
            response.config!.cronjobLogLocationTime!;
        mainController.baseUrl.value = response.baseUrl!.image!;
        mainController.notifActiveTeknisi.value =
            response.dashboard!.notifications!.totalUnread!;

        List<ListsActivity> last_activities =
            response.dashboard!.lastActivities!.lists!;

        mainController.lastPresences.value = last_activities
            .where((ListsActivity activity) => activity.type! == "PRESENSI")
            .toList();

        Map<String, String> body2 = <String, String>{
          'session_id': response.sessionId!,
          'user_id': response.user!.id.toString(),
          'filter[date][start_date]': '2021-10-26',
          'filter[date][end_date]':
              DateFormat("yyyy-MM-dd").format(DateTime.now()),
          'filter[type][AKTIFITAS]': 'no',
          'filter[type][LOCATION]': 'yes',
          'filter[type][PRESENSI]': 'no',
          'page': '1'
        };

        ProviderException response2 =
            await ActivityProvider().requestListAcivity(body2);

        if (response2.status == "success") {
          mainController.lastLocations.value = response2.data.lists;
        }

        sessionId = response.sessionId!;
        user = response.user;
      }

      _authStateStream.value = Authenticated(user: user);

      Store.saveSessionId(sessionId);
      Store.saveUser(user);
      // Store.saveDashboard(dashboard);

      mainController.userPosition.value = user.userType!;
      mainController.user.value = user;

      return ProviderException(message: "Success", status: "success");
    }
  }

  void requestLogout() async {
    _authStateStream.value = UnAuth();
    mainController.userPosition.value = "";
    mainController.selectedIndex.value = 0;
    Store.deleteUser();
    Store.deleteDashboard();
    Store.deleteSessionId();
  }

  void getAuthenticatedUser() async {
    User? user = await Store.getUser();

    _authStateStream.value = AuthLoading();

    if (user == null) {
      _authStateStream.value = UnAuth();
    } else {
      String? sessionId = await Store.getSessionId();
      Map<String, String> body = <String, String>{'session_id': sessionId!};

      ProviderException response =
          await GeneralrProvider().requestDashboard(body);

      if (response.status == "failed") {
        _authStateStream.value = UnAuth();
      } else {
        if (response.data is UserAdminResponse) {
          mainController.dashboardAdmin.value = response.data.dashboard;
          mainController.users.value = response.data.dashboard.users;
          dashboardController.usersTeknisi.value =
              response.data.dashboard.users!.lists!;
        } else if (response.data is UserRocLeaderResponse) {
          if (response.data.dashboard.idleUsers is List<User>) {
            List<User> idleUsers = response.data.dashboard.idleUsers;
            // idleUsers.map((item) => json.decode(item.dataDescription!));
            mainController.idleUsers.value = idleUsers;
          } else {
            mainController.idleUsers.value = [];
          }
          mainController.dashboardRocLeader.value = response.data.dashboard;
          mainController.notifActiveRoc.value =
              response.data.dashboard.notifications!.totalUnread!;
        } else if (response.data is UserTeknisiResponse) {
          Map<String, String> body2 = <String, String>{
            'session_id': sessionId,
            'user_id': user.id.toString(),
            'filter[date][start_date]': '2021-10-26',
            'filter[date][end_date]':
                DateFormat("yyyy-MM-dd").format(DateTime.now()),
            'filter[type][AKTIFITAS]': 'no',
            'filter[type][LOCATION]': 'yes',
            'filter[type][PRESENSI]': 'no',
            'page': '1'
          };

          ProviderException response2 =
              await ActivityProvider().requestListAcivity(body2);

          if (response2.status == "success") {
            mainController.lastLocations.value = response2.data.lists;
          }

          mainController.dashboardTeknisi.value = response.data.dashboard;
          mainController.cronjobLogLocationTime.value =
              response.data.config.cronjobLogLocationTime;
          mainController.baseUrl.value = response.data.baseUrl.image;
          if (response.data.dashboard.notifications != null &&
              response.data.dashboard.notifications.totalUnread != null) {
            mainController.notifActiveTeknisi.value =
                response.data.dashboard.notifications.totalUnread!;
          }

          List<ListsActivity> last_activities =
              response.data.dashboard.lastActivities.lists;

          mainController.lastPresences.value = last_activities
              .where((ListsActivity activity) => activity.type! == "PRESENSI")
              .toList();
        }
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      if (response.data.app.version != packageInfo.version) {
        Get.dialog(InfoApp(
            title: "Smart Assurance",
            descriptions: "descriptions",
            onTap: () async {
              await launch(response.data.app.urlDownload);
            },
            text: "text"));
      }

      mainController.userPosition.value = user.userType!;

      mainController.user.value = user;

      _authStateStream.value = Authenticated(user: user);
    }
  }
}
