import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/header_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/user_item_view.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/input/input_default_view.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class DashboardAdminView extends GetView<DashboardController> {
  var _controller = Get.put(DashboardController());
  var _mainController = Get.put(MainController());
  var _authController = Get.put(AuthController());
  DashboardAdminView();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Obx(() {
            return HeaderView(
                onLogout: () {
                  _authController.requestLogout();
                  // Get.offAllNamed(Routes.LOGIN);
                },
                type: _mainController.userPosition.value,
                name: _controller.mainController.user.value.name!,
                position: _mainController.userPosition.value,
                avatar: 'assets/images/avatar2.png');
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: InputDefaultView(
              hint: "Cari",
              leftIcon: Icons.search,
              // controller: _controller.searchController,
              onChanged: _controller.onSearchChanged,
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(() {
              return ListView.builder(
                  itemCount: _controller.usersTeknisi.length,
                  padding: EdgeInsets.only(top: 5, bottom: 150),
                  itemBuilder: (context, index) {
                    return UserItemView(
                        onTap: () {
                          // Get.toNamed(Routes.FORM_USER,
                          //     arguments: controller.users[index]);
                        },
                        onDelete: () {
                          // set up the buttons
                          Widget cancelButton = FlatButton(
                            child: Text("Reset Password"),
                            onPressed: () {
                              _controller.onResetPassword(
                                  _controller.usersTeknisi[index].id);
                            },
                          );
                          Widget continueButton = FlatButton(
                            child: Text("Hapus"),
                            onPressed: () {
                              _controller.onDeleteUser(
                                  _controller.usersTeknisi[index].id);
                            },
                          );
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            // title: Text("Konfirmasi"),
                            content: Text(
                                "Apakah anda yakin ingin hapus atau reset password user ini?"),
                            actions: [
                              cancelButton,
                              continueButton,
                            ],
                          );
                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        name: _controller.usersTeknisi[index].name!,
                        position: _controller.usersTeknisi[index].userType!,
                        avatar: "assets/images/avatar2.png");
                  });
            }),
            // child: Obx(() {
            //   return _controller.isLoading == true
            //       ? Center(
            //           child: CircularProgressIndicator(),
            //         )
            //       : ListView.builder(
            //           itemCount: _controller.usersTeknisi.length,
            //           padding: EdgeInsets.only(top: 5, bottom: 150),
            //           itemBuilder: (context, index) {
            //             return UserItemView(
            //                 onTap: () {
            //                   // Get.toNamed(Routes.FORM_USER,
            //                   //     arguments: controller.users[index]);
            //                 },
            //                 onDelete: () {
            //                   // set up the buttons
            //                   Widget cancelButton = FlatButton(
            //                     child: Text("Batal"),
            //                     onPressed: () {
            //                       Get.back();
            //                     },
            //                   );
            //                   Widget continueButton = FlatButton(
            //                     child: Text("Hapus"),
            //                     onPressed: () {
            //                       Get.back();
            //                     },
            //                   );
            //                   // set up the AlertDialog
            //                   AlertDialog alert = AlertDialog(
            //                     // title: Text("Konfirmasi"),
            //                     content: Text(
            //                         "Apakah anda yakin ingin hapus user ini?"),
            //                     actions: [
            //                       cancelButton,
            //                       continueButton,
            //                     ],
            //                   );
            //                   // show the dialog
            //                   showDialog(
            //                     context: context,
            //                     builder: (BuildContext context) {
            //                       return alert;
            //                     },
            //                   );
            //                 },
            //                 name: _controller.usersTeknisi[index].name!,
            //                 position: _controller.usersTeknisi[index].userType!,
            //                 avatar: "assets/images/avatar2.png");
            //           });
            // }),
          ),
        ],
      ),
    );
  }
}
