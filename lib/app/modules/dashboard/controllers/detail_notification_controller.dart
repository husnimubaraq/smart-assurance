import 'package:get/get.dart';
import 'package:tracking/app/data/models/notifications_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/notification_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/dashboard/controllers/notification_controller.dart';

class DetailNotificationController extends GetxController {
  //TODO: Implement DetailNotificationController
  // final NotificationController notificationController = Get.find();
  var notificationController = Get.put(NotificationController());

  var detail = ListsNotification(
          createdDate: "",
          id: 1,
          message: "",
          readDatetime: "",
          readStatus: "",
          targetUserId: 1,
          title: "",
          userId: 1,
          type: "")
      .obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('test');
    init();
  }

  void init() async {
    // User? user = await Store.getUser();
    String? sessionId = await Store.getSessionId();
    String id_notif = Get.arguments;

    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'id': id_notif,
    };

    ProviderException response =
        await NotificationProvider().requestDetailtNotification(body);

    if (response.status == "success") {
      detail.value = response.data;
      // Notifications notifications = response.data;
      // listNotifications.value = notifications.lists!;
      notificationController.init();
    } else {}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
