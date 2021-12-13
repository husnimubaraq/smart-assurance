import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';

class InfoApp extends GetView {
  InfoApp(
      {required this.title,
      required this.descriptions,
      required this.text,
      this.onTap});
  final String title, descriptions, text;
  Image? img;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 1), blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "New Version",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "The new version of Smart Assurance is now available for downloading",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: onTap,
                    child: Text(
                      "Download",
                      style: TextStyle(fontSize: 18, color: kPrimaryColor),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
                child: Image.asset("assets/images/app.png")),
          ),
        ),
      ],
    );
  }
}
