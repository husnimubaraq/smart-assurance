import 'package:get/get.dart';

import 'package:tracking/app/modules/activity/controllers/upload_photo_controller.dart';

class UploadPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadPhotoController>(
      () => UploadPhotoController(),
    );
  }
}
