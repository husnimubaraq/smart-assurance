import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/modules/dashboard/controllers/notification_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/notification_item_view.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/header/header_view.dart';
import '../../../helper/size_config.dart';
import '../../../helper/contants.dart';

class NotificationView extends GetView<NotificationController> {
  var _controller = Get.put(NotificationController());
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
            child: RefreshIndicator(
              onRefresh: _controller.onRefressh,
              child: Obx(() {
                if (controller.listNotifications.length > 0) {
                  return ListView.builder(
                      itemCount: controller.listNotifications.length,
                      padding: EdgeInsets.only(top: 5),
                      itemBuilder: (context, index) {
                        return NotificationItemView(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_NOTIFICATION,
                                  arguments: controller
                                      .listNotifications[index].id
                                      .toString());
                            },
                            isRead: controller
                                    .listNotifications[index].readStatus !=
                                "read",
                            name: controller.listNotifications[index].title!,
                            description:
                                controller.listNotifications[index].message!,
                            date: controller
                                .listNotifications[index].createdDate!);
                      });
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Tidak ada data",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          )
        ],
      )),
    );
  }
}
