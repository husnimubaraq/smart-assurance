import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/controller/auth_state.dart';
import 'package:tracking/app/data/models/technician_model.dart';
import 'package:tracking/app/data/models/technician_presence_model.dart';
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
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class DashboardController extends GetxController {
  // var authController = Get.put(AuthController());
  var mainController = Get.put(MainController());

  // User? user;
  // var dashboard;

  List<User> users = [];

  List<User> teknisiUsers = [];
  var activityTeknisi = <ListsActivity>[].obs;

  // var usersTeknisi = List<ListsUser>.from([]).obs;

  late TextEditingController searchController;

  var isLoading = false.obs;
  final usersTeknisi = [].obs;
  Timer? _debounce;

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    // init();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('ready');
  }

  void onSearchChanged(String query) {
    // if (_debounce!.isActive) _debounce!.cancel();

    // _debounce = Timer(const Duration(milliseconds: 500), () {
    //   usersTeknisi.value = usersTeknisi.value
    //       .where(
    //           (value) => value.name.toLowerCase().contains(query.toLowerCase()))
    //       .toList();
    //   // fetchData(query);
    // });
    if (query.length > 0) {
      usersTeknisi.value = usersTeknisi
          .where(
              (value) => value.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      fetchData("");
    }
  }

  void initSendLocation(double latitude, double longitude) {
    print("init send location: ${latitude} ${longitude}");
    Fluttertoast.showToast(
        msg: "Presensi berhasil ditambahkan!",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kSuccessColor,
        toastLength: Toast.LENGTH_LONG);
    fetchData("");
    Get.back();
  }

  void sendLocation(double latitude, double longitude) async {
    var getAddress =
        await GeneralrProvider().requestGetAddress(latitude, longitude);
    print("send location: ${latitude} ${longitude}");
    if (getAddress.length > 0) {
      print("send location: ${latitude} ${longitude}");
      String? sessionId = await Store.getSessionId();
      Map<String, String> body = <String, String>{
        'session_id': sessionId!,
        "longitude": longitude.toString(),
        "latitude": latitude.toString(),
        "address": getAddress[0].formattedAddress!
      };

      ProviderException responseAddPresence =
          await ActivityProvider().requestAddLoction(body);

      if (responseAddPresence.status == "failed") {
        print("add location failed");
      } else {
        print("add location success");
        fetchData("");
      }
    } else {
      print("Tidak ada alamat");
    }
  }

  void fetchData(String query) async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : ""
    };

    ProviderException response =
        await GeneralrProvider().requestDashboard(body);
    print("fetch dashboard");
    if (response.status == "failed") {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      if (response.data is UserAdminResponse) {
        mainController.dashboardAdmin.value = response.data.dashboard;
        mainController.users.value = response.data.dashboard.users;
        usersTeknisi.value = response.data.dashboard.users.lists;

        isLoading(false);
      } else if (response.data is UserRocLeaderResponse) {
        mainController.idleUsers.value =
            response.data.dashboard.idleUsers is List<IdleUsers>
                ? response.data.dashboard.idleUsers
                : [];
        mainController.dashboardRocLeader.value = response.data.dashboard;
      } else if (response.data is UserTeknisiResponse) {
        mainController.dashboardTeknisi.value = response.data.dashboard;

        List<ListsActivity> last_activities =
            response.data.dashboard.lastActivities.lists;

        mainController.lastLocations.value = last_activities
            .where((ListsActivity activity) => activity.type! == "LOCATION")
            .toList();
      }
    }
  }

  Future<void> onRefressh() async {
    return Future.delayed(Duration(seconds: 2), () {
      fetchData('');
    });
  }

  Future<void> filterData(String keyword) async {
    if (keyword.length > 3) {
    } else {
      fetchData("");
    }
  }

  User findUserById(int id) {
    return users.firstWhere((element) => element.id == id);
  }

  void onDeleteUser(dynamic id_user) async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "user_id": id_user.toString()
    };

    var response = await UserProvider().requestDeleteUser(body);
    if (response.status == "failed") {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);
      fetchData("");
      Get.back();
    }
  }

  void onResetPassword(dynamic id_user) async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "user_id": id_user.toString()
    };

    var response = await UserProvider().requestResetPassword(body);
    if (response.status == "failed") {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);
      fetchData("");
      Get.back();
    }
  }
}
