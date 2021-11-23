import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ButtonView extends GetView {
  ButtonView(
      {required this.label,
      required this.onTap,
      this.width = 0,
      this.paddingVertical = 15,
      this.fontSize = 16,
      this.backgroundColor,
      this.color});
  final String label;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? color;
  double width;
  double paddingVertical;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
          width: width > 0 ? width : double.infinity,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: paddingVertical),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: fontSize,
                      color: color,
                      fontWeight: FontWeight.w500),
                ),
              )),
        ));
  }
}
