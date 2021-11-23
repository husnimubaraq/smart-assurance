import 'package:get/get.dart';

import 'package:tracking/app/modules/manage/controllers/manage_map_user_controller.dart';

class ManageMapUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageMapUserController>(
      () => ManageMapUserController(),
    );
  }
}
