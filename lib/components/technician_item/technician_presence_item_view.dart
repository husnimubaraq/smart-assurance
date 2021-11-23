import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';

class TechnicianPresenceItemView extends GetView {
  static const CHECKIN = "checkin";
  static const CHECKOUT = "checkout";

  TechnicianPresenceItemView(
      {required this.name,
      required this.date,
      required this.avatar,
      required this.status,
      this.type});
  final String avatar;
  final String name;
  final String date;
  final String status;
  String? type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                type == "technician"
                    ? Icon(Icons.access_time)
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(avatar),
                      ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(200),
                            child: Text(
                              name,
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
                      Text(
                        date,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: status == CHECKIN ? Colors.blue[200] : Colors.red[200],
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
