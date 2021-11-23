import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  initializeFCM() async {
    print('test');
    // await requestPermissions();
    // await checkPermissions();
    FirebaseMessaging.instance.getToken().then(setToken);
  }

  void setToken(String? token) {
    print(token);
  }

  Future<void> requestPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  Future<void> checkPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
