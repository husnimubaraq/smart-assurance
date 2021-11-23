import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';

class TechnicianLocationItemView extends GetView {
  TechnicianLocationItemView(
      {required this.name,
      required this.location,
      required this.avatar,
      this.category,
      this.onTap,
      this.type});
  final String avatar;
  final String name;
  final String location;
  String? category;
  String? type;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  type == "technician"
                      ? Icon(FeatherIcons.mapPin)
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
                              width: getProportionateScreenWidth(270),
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
                          category!,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          location,
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
          ],
        ),
      ),
    );
  }
}
