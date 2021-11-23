import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/modules/dashboard/controllers/notification_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/notification_item_view.dart';
import 'package:tracking/components/header/header_view.dart';
import '../../../helper/size_config.dart';
import '../../../helper/contants.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(
            title: "Notifikasi",
            separator: false,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: controller.notifications.length,
                padding: EdgeInsets.only(top: 5),
                itemBuilder: (context, index) {
                  return NotificationItemView(
                      name: controller.notifications[index].title!,
                      description: controller.notifications[index].description!,
                      date: controller.notifications[index].date!);
                }),
          )
        ],
      )),
    );
  }
}
