import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class HeaderView extends GetView {
  HeaderView(
      {required this.title,
      this.separator = true,
      this.hideLeft = false,
      this.iconRight,
      this.onTapRight});
  final String title;
  bool separator;
  bool hideLeft;
  IconData? iconRight;
  Function()? onTapRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: kWhiteColor,
          border: separator
              ? Border(bottom: BorderSide(color: Colors.black12, width: 1))
              : Border(bottom: BorderSide.none)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          setHideLeft(hideLeft),
          Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
            ),
          ),
          setHideRight(iconRight == null)
        ],
      ),
    );
  }

  Widget setHideRight(bool hideRight) {
    if (hideRight) {
      return SizedBox();
    } else {
      return InkWell(
        onTap: onTapRight,
        child: Icon(
          iconRight,
          size: 20,
        ),
      );
    }
  }

  Widget setHideLeft(bool hideLeft) {
    if (hideLeft) {
      return SizedBox();
    } else {
      return InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.chevron_left),
      );
    }
  }
}
