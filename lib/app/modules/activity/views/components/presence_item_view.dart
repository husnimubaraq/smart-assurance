import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/components/button/button_view.dart';

class PresenceItemView extends GetView {
  PresenceItemView(
      {required this.label,
      required this.timer,
      required this.onTap,
      this.color = kPrimaryColor});

  String label;
  String timer;
  Color color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        children: [
          Text(
            timer,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(5)),
              child: Text(
                label,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
          // ButtonView(label: label, onTap: onTap)
        ],
      ),
    );
  }
}
