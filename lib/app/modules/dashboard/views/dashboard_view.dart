import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/modules/dashboard/views/components/dashboard_admin_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/dashboard_roc_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/dashboard_technician_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/header_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';
import 'components/tab_item_view.dart';
import '../../../helper/size_config.dart';
import '../../../helper/contants.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  var _controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: kSnowColor,
        body: SafeArea(
          child: Column(
            children: [
              _controller.userPosition == USER_ADMIN
                  ? DashboardAdminView()
                  : _controller.userPosition.value == USER_TEKNISI
                      ? DashboardTechnicianView()
                      : DashboardRocView(),
              // DashboardRocView()
              // DashboardTechnicianView()

              // SizedBox(
              //   height: 300,
              //   child:
              // )
            ],
          ),
        ));
  }
}
