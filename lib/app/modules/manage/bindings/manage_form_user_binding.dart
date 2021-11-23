import 'package:get/get.dart';

import 'package:tracking/app/modules/manage/controllers/manage_form_user_controller.dart';

class ManageFormUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageFormUserController>(
      () => ManageFormUserController(),
    );
  }
}
