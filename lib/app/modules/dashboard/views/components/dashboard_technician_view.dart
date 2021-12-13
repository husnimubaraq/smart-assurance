import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/header_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/tab_item_view.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class DashboardTechnicianView extends GetView<DashboardController> {
  var _controller = Get.put(DashboardController());
  var _mainController = Get.put(MainController());

  DashboardTechnicianView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: _controller.onRefressh,
          child: ListView(
            children: [
              Obx(() {
                return HeaderView(
                    notifActive:
                        _controller.mainController.notifActiveTeknisi.value > 0,
                    type: _mainController.userPosition.value,
                    name: _controller.mainController.user.value.name!,
                    position: _mainController.userPosition.value,
                    avatar: 'assets/images/avatar2.png');
              }),
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
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Presensi",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _mainController.dashboardTeknisi.value.presensi!
                                      .checkin !=
                                  null
                              ? ItemPresensi(
                                  "Checkin",
                                  _mainController.dashboardTeknisi.value
                                          .presensi!.checkin!.status !=
                                      "none",
                                  _mainController.dashboardTeknisi.value
                                              .presensi!.checkin!.datetime !=
                                          null
                                      ? _mainController.dashboardTeknisi.value
                                          .presensi!.checkin!.datetime!
                                      : "",
                                  "",
                                  _mainController.dashboardTeknisi.value
                                      .presensi!.checkin!.status!)
                              : SizedBox(),
                          SizedBox(
                            height: 20,
                          ),
                          _mainController.dashboardTeknisi.value.presensi!
                                      .checkout !=
                                  null
                              ? ItemPresensi(
                                  "Checkout",
                                  _mainController.dashboardTeknisi.value
                                          .presensi!.checkout!.status !=
                                      "none",
                                  _mainController.dashboardTeknisi.value
                                              .presensi!.checkout!.datetime !=
                                          null
                                      ? _mainController.dashboardTeknisi.value
                                          .presensi!.checkout!.datetime!
                                      : "",
                                  "",
                                  _mainController.dashboardTeknisi.value
                                      .presensi!.checkout!.status!)
                              : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() {
                return SectionListView(
                    label: "Log Location",
                    itemLength: _mainController.lastLocations.value!.length,
                    onTapMore: () {
                      Get.toNamed(Routes.LOG_ACTIVITY,
                          arguments: {"filter": "LOCATION"});
                    },
                    child: Column(
                      children: List.generate(
                          _mainController.lastLocations.value!.length, (index) {
                        return TechnicianLocationItemView(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_ACTIVITY,
                                  arguments: _mainController
                                      .lastLocations.value![index]);
                            },
                            category: _mainController
                                .lastLocations.value![index].type!,
                            type: "technician",
                            name: _mainController
                                .lastLocations.value![index].address!,
                            location: _mainController
                                .lastLocations.value![index].createdDate!,
                            avatar: '');
                      }),
                    ));
              }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }

  Container ItemPresensi(String label, bool checkPresensi, String date,
      String address, String? status) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${label}:",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: kDangerColor,
                fontWeight: FontWeight.bold),
          ),
          visiblePresensi(label, checkPresensi, date, address, status),
        ],
      ),
    );
  }

  Widget visiblePresensi(String label, bool visible, String? date,
      String? address, String? status) {
    if (visible) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status!,
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 14, color: Colors.blue[300]),
          ),
          Text(
            date!,
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 12, color: Colors.black45),
          ),
          Text(
            address!,
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 14, color: Colors.black87),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    } else {
      return Text(
        "Anda belum melakukan ${label}",
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 14, color: Colors.black87),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
