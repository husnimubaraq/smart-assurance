import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/detail_summary_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/section_list/section_list_view.dart';

import 'components/user_item_view.dart';

class DetailSummaryView extends GetView<DetailSummaryController> {
  var _controller = Get.put(DetailSummaryController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    String typeSummary = Get.arguments;
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderView(
              title: "Detail Summary",
              separator: true,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _controller.onRefresh,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    typeSummary == "presence"
                        ? Obx(() {
                            return SectionListView(
                                label: "Check In",
                                itemLength: _controller.listCheckIn.length,
                                child: Column(
                                  children: List.generate(
                                      _controller.listCheckIn.length, (index) {
                                    return UserItemView(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.DASHBOARD_DETAIL_TEKNISI,
                                              arguments: controller
                                                  .listCheckIn[index]);
                                        },
                                        date: _controller
                                            .listCheckIn[index].createdDate,
                                        name: _controller
                                            .listCheckIn[index].name!,
                                        position: _controller
                                            .listCheckIn[index].phone!,
                                        avatar: "assets/images/avatar2.png");
                                  }),
                                ));
                          })
                        : Obx(() {
                            return SectionListView(
                                label: "Online",
                                itemLength: _controller.listOnline.length,
                                child: Column(
                                  children: List.generate(
                                      _controller.listOnline.length, (index) {
                                    return UserItemView(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.DASHBOARD_DETAIL_TEKNISI,
                                              arguments:
                                                  controller.listOnline[index]);
                                        },
                                        date: _controller
                                            .listOnline[index].createdDate,
                                        name:
                                            _controller.listOnline[index].name!,
                                        position: _controller
                                            .listOnline[index].phone!,
                                        avatar: "assets/images/avatar2.png");
                                  }),
                                ));
                          }),
                    SizedBox(
                      height: 20,
                    ),
                    typeSummary == "presence"
                        ? Obx(() {
                            return SectionListView(
                                label: "Check Out",
                                itemLength: _controller.listCheckOut.length,
                                child: Column(
                                  children: List.generate(
                                      _controller.listCheckOut.length, (index) {
                                    return UserItemView(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.DASHBOARD_DETAIL_TEKNISI,
                                              arguments: controller
                                                  .listCheckOut[index]);
                                        },
                                        date: _controller
                                            .listCheckOut[index].createdDate,
                                        name: _controller
                                            .listCheckOut[index].name!,
                                        position: _controller
                                            .listCheckOut[index].phone!,
                                        avatar: "assets/images/avatar2.png");
                                  }),
                                ));
                          })
                        : Obx(() {
                            return SectionListView(
                                label: "Offline",
                                itemLength: _controller.listOffline.length,
                                child: Column(
                                  children: List.generate(
                                      _controller.listOffline.length, (index) {
                                    return UserItemView(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.DASHBOARD_DETAIL_TEKNISI,
                                              arguments: controller
                                                  .listOffline[index]);
                                        },
                                        date: _controller
                                            .listOffline[index].createdDate,
                                        name: _controller
                                            .listOffline[index].name!,
                                        position: _controller
                                            .listOffline[index].phone!,
                                        avatar: "assets/images/avatar2.png");
                                  }),
                                ));
                          }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
