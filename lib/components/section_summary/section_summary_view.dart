import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class SectionSummaryView extends GetView {
  SectionSummaryView(
      {required this.label,
      required this.leftTitle,
      required this.leftValue,
      required this.rightTitle,
      this.onTapDetail,
      required this.rightValue});
  String label;
  String leftTitle;
  String leftValue;
  String rightTitle;
  String rightValue;
  Function()? onTapDetail;

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              label,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: 100,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      leftValue,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      leftTitle,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: 100,
                decoration: BoxDecoration(
                    color: kDangerColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      rightValue,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          color: kWhiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      rightTitle,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: kWhiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: onTapDetail,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Lihat Detail",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.normal),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
