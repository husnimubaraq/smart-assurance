import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class DropdownView extends GetView {
  DropdownView(
      {required this.value,
      required this.onChange,
      this.hint,
      required this.items});
  dynamic value;
  String? hint;
  Function(dynamic position) onChange;
  List<DropdownMenuItem<dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<dynamic>(
        value: value,
        icon: const Icon(FeatherIcons.chevronDown),
        iconSize: 18,
        elevation: 0,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 12,
          color: Colors.black87,
        ),
        underline: Container(
          height: 2,
          color: Colors.transparent,
        ),
        hint: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            hint ?? "Pilih",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
        dropdownColor: kWhiteColor,
        isExpanded: true,
        onChanged: onChange,
        items: items);
  }
}
