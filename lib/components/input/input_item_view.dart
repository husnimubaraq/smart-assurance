import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';

class InputItemView extends GetView {
  InputItemView(
      {required this.label,
      required this.hint,
      this.leftIcon,
      this.keyboardNumber = false,
      this.keyboardEmail = false,
      this.rightIcon,
      this.controller,
      required this.value});
  final String label;
  final String hint;
  final String value;
  IconData? leftIcon;
  TextEditingController? controller;
  IconData? rightIcon;
  bool keyboardNumber;
  bool keyboardEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 12, color: Colors.grey),
          ),
        ),
        Flexible(
          child: Container(
            child: TextField(
              controller: controller,
              keyboardType: keyboardNumber
                  ? TextInputType.number
                  : keyboardEmail
                      ? TextInputType.emailAddress
                      : TextInputType.name,
              inputFormatters: keyboardNumber
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
              decoration: InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                focusColor: kWhiteColor,
                hintText: hint,
              ),
              textAlign: TextAlign.right,
              style: TextStyle(fontFamily: "Poppins", fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
