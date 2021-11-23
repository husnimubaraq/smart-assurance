import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/activity/controllers/detail_activity_controller.dart';
import 'package:tracking/components/header/header_view.dart';

class DetailActivityView extends GetView<DetailActivityController> {
  var _controller = Get.put(DetailActivityController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ListsActivity detail = Get.arguments;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(
            title: "Detail Activity",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              flex: 1,
              child: ListView(
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
                            detail.type!,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        detail.imageUrl!.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Center(
                                  child: InteractiveViewer(
                                    minScale: 0.2,
                                    maxScale: 50.2,
                                    child: Image.network(
                                      "http://counterpulsa.com/location/FDM/public_html/asset/image/activity/" +
                                          detail.imageUrl!,
                                      height: getProportionateScreenHeight(500),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        detail.catatan! != ""
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Catatan:",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        detail.catatan!,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        detail.category! != ""
                            ? Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "Kategori:",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        detail.category!,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            color: detail.category! == "checkin"
                                                ? Colors.lightBlueAccent
                                                : kDangerColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Waktu:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  detail.createdDate!,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Lokasi:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  detail.address!,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
