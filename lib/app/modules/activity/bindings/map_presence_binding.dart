import 'package:get/get.dart';

import 'package:tracking/app/modules/activity/controllers/map_presence_controller.dart';

class MapPresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapPresenceController>(
      () => MapPresenceController(),
    );
  }
}
