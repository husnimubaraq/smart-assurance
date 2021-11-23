import 'package:get/get.dart';

import 'package:tracking/app/modules/manage/controllers/manage_detail_user_controller.dart';

class ManageDetailUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageDetailUserController>(
      () => ManageDetailUserController(),
    );
  }
}
