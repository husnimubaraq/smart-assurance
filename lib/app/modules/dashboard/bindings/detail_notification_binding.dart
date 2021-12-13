import 'package:get/get.dart';

import 'package:tracking/app/modules/dashboard/controllers/detail_notification_controller.dart';

class DetailNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNotificationController>(
      () => DetailNotificationController(),
    );
  }
}
