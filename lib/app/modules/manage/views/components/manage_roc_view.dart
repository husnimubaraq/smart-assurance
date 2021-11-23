import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/user_item_view.dart';
import 'package:tracking/app/modules/manage/controllers/manage_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/button/button_item_view.dart';
import 'package:tracking/components/input/input_default_view.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class ManageRocView extends GetView<ManageController> {
  var _controller = Get.put(ManageController());

  ManageRocView();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Column(
      children: [
        Expanded(
          flex: 1,
          child: RefreshIndicator(
            onRefresh: _controller.onRefresh,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              width: getProportionateScreenWidth(120),
                              height: 100,
                              decoration: BoxDecoration(
                                  color: kWarningColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _controller.summaryTeamLeader.value,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Team Leader",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            width: 20,
                          ),
                          Obx(() {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              width: getProportionateScreenWidth(120),
                              height: 100,
                              decoration: BoxDecoration(
                                  color: kDangerColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _controller.summaryTeknisi.value,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 18,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Teknisi",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() {
                  return SectionListView(
                      label: "Team Leader",
                      itemLength: _controller.teamLeaderUsers.length,
                      // onTapMore: () {
                      //   // Get.toNamed(Routes.MANAGE_ALL_USER, arguments: [
                      //   //   "Team Leader",
                      //   //   controller.teamLeaderUsers
                      //   // ]);
                      // },
                      child: Column(
                        children: List.generate(
                            _controller.teamLeaderUsers.length, (index) {
                          return UserItemView(
                              onTap: () {
                                Get.toNamed(Routes.MANAGE_DETAIL_USER,
                                    arguments:
                                        _controller.teamLeaderUsers[index]);
                                // Get.toNamed(Routes.FORM_USER,
                                //     arguments: controller.rocUsers[index]);
                              },
                              name: _controller.teamLeaderUsers[index].name!,
                              position:
                                  _controller.teamLeaderUsers[index].email!,
                              avatar: "assets/images/avatar2.png");
                        }),
                      ));
                }),
                SizedBox(
                  height: 15,
                ),
                ButtonItemView(
                  label: "Tambah User",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                  onTap: () {
                    Get.toNamed(Routes.MANAGE_FORM_USER);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
