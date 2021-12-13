import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/components/button/button_view.dart';

class NotificationItemView extends GetView {
  NotificationItemView(
      {required this.name,
      required this.description,
      required this.date,
      required this.isRead,
      this.onTap});

  String name;
  String description;
  String date;
  bool isRead;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              color: kWhiteColor, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  isRead
                      ? Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: kDangerColor,
                              borderRadius: BorderRadius.circular(5)))
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                description,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
