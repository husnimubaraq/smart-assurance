import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class SectionListView extends GetView {
  SectionListView(
      {required this.label,
      this.itemLength,
      required this.child,
      this.onTapMore});
  String label;
  final Widget? child;
  final Function()? onTapMore;
  int? itemLength;

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
            height: 10,
          ),
          itemLength! > 0
              ? child!
              : Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Tidak ada data",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          setVisibleMore(onTapMore != null ? true : false),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget setVisibleMore(bool visible) {
    if (visible) {
      return InkWell(
        onTap: onTapMore,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Lihat Semua",
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
      );
    } else {
      return SizedBox();
    }
  }
}
