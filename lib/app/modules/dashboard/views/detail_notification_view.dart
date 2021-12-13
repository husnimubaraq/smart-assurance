import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/notifications_model.dart';
import 'package:tracking/app/modules/dashboard/controllers/detail_notification_controller.dart';
import 'package:tracking/components/header/header_view.dart';

class DetailNotificationView extends GetView<DetailNotificationController> {
  var _controller = Get.put(DetailNotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(
            title: "Detail Notifikasi",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: Obx(() {
                return ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.only(bottom: 15),
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
                              _controller.detail.value.title!,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              _controller.detail.value.message!,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  _controller.detail.value.createdDate!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }))
        ],
      )),
    );
  }
}
