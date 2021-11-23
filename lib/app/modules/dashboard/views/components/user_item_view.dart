import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class UserItemView extends GetView {
  UserItemView(
      {required this.name,
      required this.position,
      required this.avatar,
      this.date,
      required this.onTap,
      this.distance,
      this.onDelete});
  final String avatar;
  final String name;
  final String position;
  String? date;
  String? distance;
  final Function() onTap;
  Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: onDelete != null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(avatar),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        position,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.normal),
                      ),
                      date != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date!,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
            onDelete != null
                ? IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete,
                      color: kDangerColor,
                    ))
                : distance != null
                    ? Text(
                        distance! + " meter",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.blue[300],
                            fontWeight: FontWeight.normal),
                      )
                    : SizedBox()
          ],
        ),
      ),
    );
  }
}
