import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import '../../../helper/contants.dart';
import 'package:tracking/app/modules/profile/views/components/menu_item_view.dart';

import '../controllers/profile_controller.dart';
import '../../../helper/size_config.dart';

class ProfileView extends GetView<ProfileController> {
  var _mainController = Get.put(MainController());
  var _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: kSnowColor,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: _controller.onRefressh,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CHANGE_PROFILE,
                              arguments: _mainController.user.value);
                        },
                        child: Obx(() {
                          return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/avatar.jpeg'),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _mainController.user.value.name!,
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              _mainController
                                                  .userPosition.value,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 12,
                                                  height: 1,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  )
                                ],
                              ));
                        }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        // height: getProportionateScreenHeight(160),
                        padding: EdgeInsets.only(bottom: 15, top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.email_outlined,
                                            color: Colors.grey, size: 18),
                                      ),
                                      Text(
                                        "Email:",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _mainController.user.value.email!,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                      ),
                                      Text(
                                        "Phone:",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _mainController.user.value.phone!,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Icon(Icons.card_membership,
                                            color: Colors.grey, size: 18),
                                      ),
                                      Text(
                                        "NIK:",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _mainController.user.value.nik!,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                        color: Colors.white,
                        child: Column(
                          children: [
                            MenuItemView("Ubah Password", Icons.lock, () {
                              Get.toNamed(Routes.CHANGE_PASSWORD);
                            }),
                            MenuItemView("Logout", Icons.logout_outlined,
                                _controller.onLogout)
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        )));
  }
}
