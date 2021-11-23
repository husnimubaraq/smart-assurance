import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/modules/activity/views/activity_view.dart';
import '../../../dashboard/views/dashboard_view.dart';
import '../../controllers/main_controller.dart';
import '../../../manage/views/manage_view.dart';
import '../../../profile/views/profile_view.dart';

class Body extends GetView<MainController> {
  var _controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => IndexedStack(
              index: _controller.selectedIndex.value,
              children: [
                DashboardView(),
                _controller.userPosition.value == USER_TEKNISI
                    ? ActivityView()
                    : ManageView(),
                ProfileView()
              ],
            )));
  }
}
