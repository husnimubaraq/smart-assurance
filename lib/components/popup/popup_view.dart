import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class PopupView extends GetView {
  PopupView({required this.items, required this.onTap});

  List items;
  Function(
    int index,
  ) onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Container(
            height: 200,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white70,
                  child: Text(
                    "Filter",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            onTap(index);
                            // Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index].label,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                                FilterValue(items[index].value),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )));
  }

  Widget FilterValue(String value) {
    if (value.isNotEmpty) {
      if (value == "yes") {
        return Icon(
          Icons.check,
          color: kPrimaryColor,
        );
      } else if (value == "no") {
        return SizedBox();
      }
      return Text(value,
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              color: kPrimaryColor,
              fontWeight: FontWeight.normal));
    } else {
      return SizedBox();
    }
  }
}
