import 'package:get/get.dart';

import 'package:tracking/app/modules/dashboard/controllers/dashboard_detail_teknisi_controller.dart';

class DashboardDetailTeknisiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardDetailTeknisiController>(
      () => DashboardDetailTeknisiController(),
    );
  }
}
