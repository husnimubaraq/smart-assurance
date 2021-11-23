import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/size_config.dart';

class SubTabItemView extends GetView {
  SubTabItemView(
      {required this.onTap, required this.label, required this.active});

  Function() onTap;
  String label;
  bool active;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: active ? Colors.blue[50] : Colors.transparent,
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Text(
            label,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 10,
                color: active ? Colors.blue : Colors.black45,
                fontWeight: FontWeight.normal),
          )),
    );
  }
}
