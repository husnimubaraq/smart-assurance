import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_detail_teknisi_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/button/button_item_view.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/technician_item/technician_activity_item_view.dart';

class DashboardDetailTeknisiView
    extends GetView<DashboardDetailTeknisiController> {
  var _controller = Get.put(DashboardDetailTeknisiController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    User? user = Get.arguments;
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(title: "Detail Teknisi"),
          Expanded(
            flex: 1,
            child: RefreshIndicator(
              onRefresh: _controller.onRefresh,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.CHANGE_PROFILE);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.jpeg'),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user != null ? user.name! : "",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        user != null ? user.userType! : "",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            height: 1,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(right: 10),
                            //   child: Icon(
                            //     Icons.edit,
                            //     color: Colors.grey,
                            //     size: 18,
                            //   ),
                            // )
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return Container(
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
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.email_outlined,
                                          color: Colors.grey, size: 18),
                                    ),
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  // user != null ? user.email ?? "" : "",
                                  _controller.detailUser.value.email!,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      "Phone:",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  _controller.detailUser.value.phone!,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(Icons.card_membership,
                                          color: Colors.grey, size: 18),
                                    ),
                                    Text(
                                      "NIK:",
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Text(
                                  _controller.detailUser.value.nik!,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(horizontal: 15),
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
                          _controller.checkIn.value.status != null
                              ? ItemPresensi(
                                  "Checkin",
                                  _controller.checkIn.value.status != "none",
                                  _controller.checkIn.value.datetime != null
                                      ? _controller.checkIn.value.datetime!
                                      : "",
                                  "",
                                  _controller.checkIn.value.status!)
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          _controller.checkOut.value.status != null
                              ? ItemPresensi(
                                  "Checkout",
                                  _controller.checkOut.value.status != "none",
                                  _controller.checkOut.value.datetime != null
                                      ? _controller.checkOut.value.datetime!
                                      : "",
                                  "",
                                  _controller.checkOut.value.status!)
                              : SizedBox(),
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return SectionListView(
                        label: "Log Activity",
                        itemLength: _controller.listActivities.length,
                        onTapMore: () {
                          Get.toNamed(Routes.LOG_ACTIVITY,
                              arguments: {"id_user": user?.id});
                        },
                        child: Column(
                          children: List.generate(
                              _controller.listActivities.length, (index) {
                            return TechnicianActivityItemView(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_ACTIVITY,
                                      arguments:
                                          _controller.listActivities[index]);
                                },
                                location:
                                    _controller.listActivities[index].address!,
                                date: _controller
                                    .listActivities[index].createdDate!,
                                status: _controller
                                        .listActivities[index].category ??
                                    null,
                                description: _controller
                                            .listActivities[index].type ==
                                        "AKTIFITAS"
                                    ? _controller.listActivities[index].catatan!
                                    : _controller
                                        .listActivities[index].createdDate!,
                                activity:
                                    _controller.listActivities[index].type!);
                          }),
                        ));
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonItemView(
                      label: "Request Aktifitas",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                      onTap: _controller.sendRequestActivity),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
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
        "Belum melakukan ${label}",
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 14, color: Colors.black87),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    }
  }
}
