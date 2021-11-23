import 'package:get/get.dart';
import 'package:tracking/app/data/models/notification_model.dart';

class NotificationController extends GetxController {
  List<Notification> notifications = [
    new Notification(
        title: "Teknisi 3 checkin",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare accumsan rutrum",
        date: "baru saja"),
    new Notification(
        title: "Teknisi 2 checkin",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare accumsan rutrum",
        date: "10 menit yang lalu"),
    new Notification(
        title: "Teknisi 5 checkin",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare accumsan rutrum",
        date: "15 menit yang lalu"),
  ];

  final count = 0.obs;
  @override
  void onInit() {
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
