import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/activity/views/components/presence_item_view.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/technician_item/technician_activity_item_view.dart';

import '../controllers/activity_controller.dart';

class ActivityView extends GetView<ActivityController> {
  var _controller = Get.put(ActivityController());
  // var _controller.mainController = _controller.mainController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // var checkout = null;
    // var checkin = null;
    // if (_controller.mainController.dashboardTeknisi.value.presensi != null) {
    //   if (_controller.mainController.dashboardTeknisi.value.presensi!.checkout != null) {
    //     checkout = _controller.mainController.dashboardTeknisi.value.presensi!.checkout;
    //   }
    //   if (_controller.mainController.dashboardTeknisi.value.presensi!.checkin != null) {
    //     checkin = _controller.mainController.dashboardTeknisi.value.presensi!.checkin;
    //   }
    // }

    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: RefreshIndicator(
                onRefresh: _controller.dashboardController.onRefressh,
                child: ListView(
                  children: [
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() {
                                return PresenceItemView(
                                    label: "Check In",
                                    timer: _controller
                                                .mainController
                                                .dashboardTeknisi
                                                .value
                                                .presensi!
                                                .checkin!
                                                .status ==
                                            "none"
                                        ? "-- : --"
                                        : _controller
                                            .mainController
                                            .dashboardTeknisi
                                            .value
                                            .presensi!
                                            .checkin!
                                            .datetime!
                                            .substring(10, 16),
                                    // onTap: _controller.onCheckIn,
                                    onTap: () {
                                      if (_controller
                                              .mainController
                                              .dashboardTeknisi
                                              .value
                                              .presensi!
                                              .checkin!
                                              .status ==
                                          "none") {
                                        Get.toNamed(Routes.MAP_PRESENCE,
                                            arguments: "checkin");
                                      }
                                      // Get.toNamed(Routes.MAP_PRESENCE,
                                      //     arguments: "checkin");
                                    },
                                    color: _controller
                                                .mainController
                                                .dashboardTeknisi
                                                .value
                                                .presensi!
                                                .checkin!
                                                .status ==
                                            "none"
                                        ? Colors.lightBlue
                                        : kPrimaryColor);
                              }),
                              Obx(() {
                                return PresenceItemView(
                                  label: "Check Out",
                                  timer: _controller
                                              .mainController
                                              .dashboardTeknisi
                                              .value
                                              .presensi!
                                              .checkout!
                                              .status ==
                                          "none"
                                      ? "-- : --"
                                      : _controller
                                          .mainController
                                          .dashboardTeknisi
                                          .value
                                          .presensi!
                                          .checkout!
                                          .datetime!
                                          .substring(10, 16),
                                  // onTap: _controller.onCheckOut,
                                  onTap: () {
                                    if (_controller
                                                .mainController
                                                .dashboardTeknisi
                                                .value
                                                .presensi!
                                                .checkin!
                                                .status ==
                                            "success" &&
                                        _controller
                                                .mainController
                                                .dashboardTeknisi
                                                .value
                                                .presensi!
                                                .checkout!
                                                .status ==
                                            "none") {
                                      Get.toNamed(Routes.MAP_PRESENCE,
                                          arguments: "checkout");
                                    }
                                    // Get.toNamed(Routes.MAP_PRESENCE,
                                    //     arguments: "checkout");
                                  },
                                  color: (_controller
                                                  .mainController
                                                  .dashboardTeknisi
                                                  .value
                                                  .presensi!
                                                  .checkin!
                                                  .status ==
                                              "success" &&
                                          _controller
                                                  .mainController
                                                  .dashboardTeknisi
                                                  .value
                                                  .presensi!
                                                  .checkout!
                                                  .status ==
                                              "none")
                                      ? kDangerColor
                                      : kDangerLightColor,
                                );
                              })
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        // Get.toNamed(Routes.UPLOAD_PHOTO);
                        if (_controller.mainController.dashboardTeknisi.value
                                .presensi!.checkin!.status ==
                            "none") {
                          Fluttertoast.showToast(
                              msg: "Anda belum melakukan Check In",
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: kDangerColor,
                              toastLength: Toast.LENGTH_SHORT);
                        } else if (_controller.mainController.dashboardTeknisi
                                    .value.presensi!.checkin!.status !=
                                "none" &&
                            _controller.mainController.dashboardTeknisi.value
                                    .presensi!.checkout!.status ==
                                "none") {
                          Get.toNamed(Routes.UPLOAD_PHOTO);
                        }
                      },
                      child: Container(
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
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Tambah Activity",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 15),
                                  //   child: Text(
                                  //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                                  //     style: TextStyle(
                                  //         fontFamily: "Poppins",
                                  //         fontSize: 12,
                                  //         color: Colors.black45),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(flex: 1, child: Icon(Icons.chevron_right))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(() {
                      return SectionListView(
                          label: "Log Activity",
                          itemLength: _controller
                              .mainController
                              .dashboardTeknisi
                              .value
                              .lastActivities!
                              .lists!
                              .length,
                          onTapMore: () {
                            Get.toNamed(Routes.LOG_ACTIVITY);
                          },
                          child: Column(
                            children: List.generate(
                                _controller
                                    .mainController
                                    .dashboardTeknisi
                                    .value
                                    .lastActivities!
                                    .lists!
                                    .length, (index) {
                              return TechnicianActivityItemView(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_ACTIVITY,
                                        arguments: _controller
                                            .mainController
                                            .dashboardTeknisi
                                            .value
                                            .lastActivities!
                                            .lists![index]);
                                    var test = _controller
                                        .mainController
                                        .dashboardTeknisi
                                        .value
                                        .lastActivities!
                                        .lists![index];
                                  },
                                  location: _controller
                                      .mainController
                                      .dashboardTeknisi
                                      .value
                                      .lastActivities!
                                      .lists![index]
                                      .address!,
                                  date: _controller
                                      .mainController
                                      .dashboardTeknisi
                                      .value
                                      .lastActivities!
                                      .lists![index]
                                      .createdDate!,
                                  status: _controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].category !=
                                          null
                                      ? (_controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].category == "general" ||
                                              _controller
                                                      .mainController
                                                      .dashboardTeknisi
                                                      .value
                                                      .lastActivities!
                                                      .lists![index]
                                                      .category ==
                                                  "eskalasi")
                                          ? ""
                                          : _controller
                                              .mainController
                                              .dashboardTeknisi
                                              .value
                                              .lastActivities!
                                              .lists![index]
                                              .category
                                      : "",
                                  description:
                                      _controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].type == "AKTIFITAS"
                                          ? _controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].catatan!
                                          : _controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].createdDate!,
                                  activity: _controller.mainController.dashboardTeknisi.value.lastActivities!.lists![index].type!);
                            }),
                          ));
                    }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
