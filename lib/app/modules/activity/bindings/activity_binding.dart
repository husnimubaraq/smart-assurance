import 'package:get/get.dart';

import 'package:tracking/app/modules/activity/controllers/detail_activity_controller.dart';

import '../controllers/activity_controller.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailActivityController>(
      () => DetailActivityController(),
    );
    Get.lazyPut<ActivityController>(
      () => ActivityController(),
    );
  }
}
