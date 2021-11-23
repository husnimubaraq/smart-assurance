import 'package:get/get.dart';

import 'package:tracking/app/modules/dashboard/controllers/detail_summary_controller.dart';

// import 'package:tracking/app/controller/auth_controller.dart';

class DetailSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSummaryController>(
      () => DetailSummaryController(),
    );
  }
}
