import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';

class TechnicianActivityItemView extends GetView {
  static const CHECKIN = "checkin";
  static const CHECKOUT = "checkout";

  TechnicianActivityItemView(
      {required this.location,
      required this.date,
      this.status,
      required this.description,
      this.onTap,
      required this.activity});
  String location;
  String date;
  String? status;
  String activity;
  String description;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                setIconLog(activity),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(270),
                              child: Text(
                                location,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    description,
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              Text(
                                status ?? "",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    color: status == CHECKIN
                                        ? Colors.blue[200]
                                        : Colors.red[200],
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Icon setIconLog(String log) {
    if (log == "PRESENSI") {
      return Icon(Icons.access_time);
    } else if (log == "LOCATION") {
      return Icon(FeatherIcons.mapPin);
    } else {
      return Icon(FeatherIcons.camera);
    }
  }
}
