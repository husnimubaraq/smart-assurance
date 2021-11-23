import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';

class TabItemView extends GetView {
  TabItemView(
      {required this.onTap,
      required this.index,
      required this.label,
      required this.active});

  Function() onTap;
  int index;
  String label;
  bool active;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: active
              ? const EdgeInsets.all(10)
              : EdgeInsets.only(left: 10, top: 15),
          child: Text(
            label,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: active ? 18 : 12,
                color: active ? Colors.black87 : Colors.black45,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
