import 'package:get/get.dart';
import 'package:tracking/app/data/models/notifications_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/notification_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/store.dart';

class NotificationController extends GetxController {
  var listNotifications = <ListsNotification>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> onRefressh() async {
    return Future.delayed(Duration(seconds: 2), () {
      init();
    });
  }

  void init() async {
    User? user = await Store.getUser();
    String? sessionId = await Store.getSessionId();

    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'upline_user_id': user!.id.toString(),
    };

    ProviderException response =
        await NotificationProvider().requestListNotification(body);

    if (response.status == "success") {
      Notifications notifications = response.data;
      listNotifications.value = notifications.lists!;
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
