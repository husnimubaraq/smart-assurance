import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthController>(
    //   () => AuthController(),
    // );
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
