import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/routes/app_pages.dart';

class HeaderView extends GetView {
  HeaderView(
      {required this.name,
      required this.position,
      required this.avatar,
      this.onLogout,
      this.type});
  final String name;
  final String position;
  final String avatar;
  String? type;
  Function()? onLogout;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Smart Assurance",
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              type == USER_ADMIN
                  ? IconButton(
                      onPressed: onLogout, icon: Icon(FeatherIcons.logOut))
                  : IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.NOTIFICATION);
                      },
                      icon: Icon(FeatherIcons.bell))
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        type == "admin"
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(avatar),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Halo ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            position,
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                height: 1,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
        type == "admin"
            ? SizedBox()
            : SizedBox(
                height: getProportionateScreenHeight(30),
              ),
      ],
    );
  }
}
