import 'package:get/get.dart';

import 'package:tracking/app/modules/profile/controllers/change_password_controller.dart';
import 'package:tracking/app/modules/profile/controllers/change_profile_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeProfileController>(
      () => ChangeProfileController(),
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
