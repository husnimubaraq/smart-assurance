import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tracking/app/routes/app_pages.dart';

import '../controllers/main_controller.dart';
import 'components/body_view.dart';
import '../../../helper/size_config.dart';

class MainView extends GetView<MainController> {
  var _controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: null,
      body: _controller.userPosition.value == USER_ADMIN
          ? DashboardView()
          : Body(),
      floatingActionButton: _controller.userPosition.value == USER_ADMIN
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () {
                Get.toNamed(Routes.FORM_USER);
              },
              child: const Icon(Icons.add),
              backgroundColor: kPrimaryColor,
            )
          : null,
      floatingActionButtonLocation: _controller.userPosition.value == USER_ADMIN
          ? FloatingActionButtonLocation.endFloat
          : null,
      bottomNavigationBar: _controller.userPosition.value == USER_ADMIN
          ? null
          : Obx(() => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: BottomNavigationBar(
                backgroundColor: kWhiteColor,
                elevation: 5,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  tabByPosition(_controller.userPosition.value,
                      _controller.selectedIndex.value),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Profil',
                  ),
                ],
                currentIndex: _controller.selectedIndex.value,
                onTap: _controller.onItemTapped,
              ))),
    );
  }

  BottomNavigationBarItem tabByPosition(String position, int index) {
    if (position != USER_TEKNISI) {
      return BottomNavigationBarItem(
        icon: Icon(Icons.manage_accounts),
        label: 'Manage',
      );
    } else {
      return BottomNavigationBarItem(
        icon: Icon(Icons.local_activity),
        label: 'Aktifitas',
      );
    }
  }
}
