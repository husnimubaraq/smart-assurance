import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart'
    as RocLeader;
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/header_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/user_item_view.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/section_summary/section_summary_view.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class DashboardRocView extends GetView<DashboardController> {
  var _controller = Get.put(DashboardController());
  // var _mainController = Get.put(MainController());

  DashboardRocView();

  @override
  Widget build(BuildContext context) {
    String avatar = "avatar2.png";
    if (_controller.mainController.user.value.userType! == USER_ROC) {
      avatar = "avatar4.png";
    } else if (_controller.mainController.user.value.userType! == USER_SM) {
      avatar = "avatar5.png";
    } else if (_controller.mainController.user.value.userType! ==
        USER_TEAMLEADER) {
      avatar = "avatar.jpeg";
    }
    return Expanded(
      flex: 1,
      child: RefreshIndicator(
        onRefresh: _controller.onRefressh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Obx(() {
              return HeaderView(
                  notifActive:
                      _controller.mainController.notifActiveRoc.value > 0,
                  type: _controller.mainController.userPosition.value,
                  name: _controller.mainController.user.value.name!,
                  position: _controller.mainController.userPosition.value,
                  avatar: 'assets/images/${avatar}');
            }),
            SectionSummaryView(
              onTapDetail: () {
                Get.toNamed(Routes.DETAIL_SUMMARY, arguments: "presence");
              },
              label: "Presensi Harian Teknisi",
              leftTitle: "Checkin",
              leftValue:
                  "${_controller.mainController.dashboardRocLeader.value.presence!.success!}",
              rightTitle: "Checkout",
              rightValue:
                  "${_controller.mainController.dashboardRocLeader.value.presence!.waiting!}",
            ),
            SizedBox(
              height: 15,
            ),
            SectionSummaryView(
              onTapDetail: () {
                Get.toNamed(Routes.DETAIL_SUMMARY, arguments: "online");
              },
              label: "Teknisi dalam Pantauan",
              leftTitle: "Online",
              leftValue:
                  "${_controller.mainController.dashboardRocLeader.value.onlineStatus!.success!}",
              rightTitle: "Offline",
              rightValue:
                  "${_controller.mainController.dashboardRocLeader.value.onlineStatus!.waiting!}",
            ),
            SizedBox(
              height: 15,
            ),
            SectionListView(
                label: "Teknisi Idle",
                itemLength: _controller.mainController.idleUsers.value!.length,
                child: Obx(() {
                  return Column(
                    children: List.generate(
                        _controller.mainController.idleUsers.value!.length,
                        (index) {
                      return UserItemView(
                          onTap: () {
                            Get.toNamed(Routes.DASHBOARD_DETAIL_TEKNISI,
                                arguments: _controller
                                    .mainController.idleUsers.value![index]);
                            // Get.toNamed(Routes.FORM_USER,
                            //     arguments: controller.rocUsers[index]);
                          },
                          date: _controller
                              .mainController
                              .idleUsers
                              .value![index]
                              .dataDescription!
                              .activites!
                              .location!
                              .createdDate,
                          distance: _controller.mainController.idleUsers
                              .value![index].distanceLocation
                              .toString(),
                          name: _controller
                              .mainController.idleUsers.value![index].name!,
                          position: _controller
                              .mainController.idleUsers.value![index].userType!,
                          avatar: "assets/images/avatar2.png");
                    }),
                  );
                })),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
