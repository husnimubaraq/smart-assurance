import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_create_prepare_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/controllers/form_user_controller.dart';
import 'package:tracking/components/button/button_view.dart';
import 'package:tracking/components/dropdown/dropdown_view.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/input/input_default_view.dart';

class FormUserView extends GetView<FormUserController> {
  var _controller = Get.put(FormUserController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    User? user = Get.arguments;

    if (user != null) {
      _controller.name.text = user.name!;
      _controller.email.text = user.email!;
      _controller.phone.text = user.nik!;
      _controller.userTypeValue.value = user.userType!;
    }

    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderView(
              title: user != null ? "Edit User" : "Tambah user",
              separator: true,
            ),
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.people,
                            size: 18,
                            color: Colors.black45,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FutureBuilder<bool>(
                              future: _controller.loadingUserType,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Obx(() {
                                  return DropdownView(
                                      value: _controller.userTypeValue.value,
                                      hint: "Pilih Tipe User",
                                      onChange: _controller.onChangeUserType,
                                      items: snapshot.hasData
                                          ? _controller.userType
                                              .map<DropdownMenuItem<dynamic>>(
                                                  (dynamic value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ),
                                                      ))
                                              .toList()
                                          : []);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.people,
                            size: 18,
                            color: Colors.black45,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: FutureBuilder<bool>(
                              future: _controller.loadingUplines,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return Obx(() {
                                  return DropdownView(
                                      value:
                                          _controller.uplineValue.value != null
                                              ? _controller.uplineValue.value
                                              : null,
                                      hint: "Pilih Uplines",
                                      onChange: _controller.onChangeUpline,
                                      items: snapshot.hasData
                                          ? _controller.uplines
                                              .map<
                                                      DropdownMenuItem<
                                                          UplineUserOptions>>(
                                                  (UplineUserOptions value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15),
                                                          child: Text(
                                                            value.name!,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ),
                                                      ))
                                              .toList()
                                          : []);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   color: kWhiteColor,
                  //   margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(left: 15),
                  //         child: Icon(
                  //           Icons.people,
                  //           size: 18,
                  //           color: Colors.black45,
                  //         ),
                  //       ),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Obx(() {
                  //           return DropdownView(
                  //               value: _controller.uplineValue,
                  //               hint: "Pilih Upline",
                  //               onChange: _controller.onChangeUpline,
                  //               items: true
                  //                   ? _controller.uplines
                  //                       .map<
                  //                               DropdownMenuItem<
                  //                                   UplineUserOptions>>(
                  //                           (UplineUserOptions value) =>
                  //                               DropdownMenuItem(
                  //                                   value: value,
                  //                                   child: Padding(
                  //                                     padding: EdgeInsets.only(
                  //                                         left: 15),
                  //                                     child: Text(
                  //                                       value.name!,
                  //                                       style: TextStyle(
                  //                                           fontFamily:
                  //                                               "Poppins",
                  //                                           fontSize: 12,
                  //                                           color:
                  //                                               Colors.black87),
                  //                                     ),
                  //                                   )))
                  //                       .toList()
                  //                   : []);
                  //         }),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    // child: InputDefaultView("Nama", "Masukan Nama",
                    //     FeatherIcons.user, null, _controller.name),
                    child: InputDefaultView(
                      label: "Nama",
                      hint: "Masukan Nama",
                      leftIcon: FeatherIcons.user,
                      controller: _controller.name,
                    ),
                  ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    // child: InputDefaultView("Nama", "Masukan Nama",
                    //     FeatherIcons.user, null, _controller.name),
                    child: InputDefaultView(
                      label: "NIK",
                      hint: "Masukan NIK",
                      leftIcon: Icons.card_membership,
                      controller: _controller.nik,
                    ),
                  ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: InputDefaultView(
                      keyboardEmail: true,
                      label: "Email",
                      hint: "Masukan Email",
                      leftIcon: FeatherIcons.mail,
                      controller: _controller.email,
                    ),
                  ),
                  Container(
                    color: kWhiteColor,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: InputDefaultView(
                      keyboardNumber: true,
                      label: "Phone",
                      hint: "Masukan Phone",
                      leftIcon: Icons.phone,
                      controller: _controller.phone,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: ButtonView(
                      label: "Simpan",
                      onTap: _controller.onSave,
                      color: kWhiteColor,
                      backgroundColor: kPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
