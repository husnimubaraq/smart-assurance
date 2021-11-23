import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';

class InputDefaultView extends GetView {
  InputDefaultView(
      {this.label,
      required this.hint,
      required this.leftIcon,
      this.rightIcon,
      this.controller,
      this.keyboardNumber = false,
      this.keyboardEmail = false,
      this.showPassword = false,
      this.onShowPassword,
      this.onChanged});
  final String? label;
  final String hint;
  final IconData leftIcon;
  final IconData? rightIcon;
  TextEditingController? controller;
  Function(String query)? onChanged;
  Function()? onShowPassword;
  bool keyboardNumber;
  bool keyboardEmail;
  bool showPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller != null ? controller : null,
      onChanged: onChanged,
      obscureText: onShowPassword == null
          ? false
          : showPassword
              ? false
              : true,
      keyboardType: keyboardNumber
          ? TextInputType.number
          : keyboardEmail
              ? TextInputType.emailAddress
              : TextInputType.name,
      inputFormatters:
          keyboardNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none),
          focusColor: kWhiteColor,
          filled: true,
          prefixIcon: Icon(
            leftIcon,
            size: 18,
          ),
          suffixIcon: onShowPassword != null
              ? IconButton(
                  onPressed: onShowPassword,
                  icon: Icon(
                      !showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye),
                )
              : null,
          fillColor: kWhiteColor,
          hintText: hint,
          labelText: label),
      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
    );
  }
}
