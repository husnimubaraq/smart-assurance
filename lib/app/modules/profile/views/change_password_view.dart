import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/profile/controllers/change_password_controller.dart';
import 'package:tracking/components/button/button_view.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/input/input_default_view.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  var _controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: kSnowColor,
        body: SafeArea(
            child: Column(
          children: [
            HeaderView(
              title: "Ubah Password",
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Container(
                      color: kWhiteColor,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      child: InputDefaultView(
                          showPassword:
                              _controller.visibleOldPassword == "false"
                                  ? false
                                  : true,
                          onShowPassword: () {
                            _controller.visibleOldPassword.value =
                                _controller.visibleOldPassword.value == "true"
                                    ? "false"
                                    : "true";
                          },
                          controller: _controller.oldPassword,
                          label: "Password Lama",
                          hint: "Masukan Password Lama",
                          leftIcon: Icons.lock_outline,
                          rightIcon: Icons.remove_red_eye_outlined),
                    );
                  }),
                  Obx(() {
                    return Container(
                      color: kWhiteColor,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      child: InputDefaultView(
                          controller: _controller.newPassword,
                          showPassword:
                              _controller.visibleNewPassword == "false"
                                  ? false
                                  : true,
                          onShowPassword: () {
                            _controller.visibleNewPassword.value =
                                _controller.visibleNewPassword.value == "true"
                                    ? "false"
                                    : "true";
                          },
                          label: "Password Baru",
                          hint: "Masukan Password Baru",
                          leftIcon: Icons.lock_outline,
                          rightIcon: Icons.remove_red_eye_outlined),
                    );
                  }),
                  Obx(() {
                    return Container(
                      color: kWhiteColor,
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      child: InputDefaultView(
                          controller: _controller.confirmPassword,
                          showPassword:
                              _controller.visibleConfirmPassword == "false"
                                  ? false
                                  : true,
                          onShowPassword: () {
                            _controller.visibleConfirmPassword.value =
                                _controller.visibleConfirmPassword.value ==
                                        "true"
                                    ? "false"
                                    : "true";
                          },
                          label: "Konfirmasi Password Baru",
                          hint: "Masukan Konfirmasi Password Baru",
                          leftIcon: Icons.lock_outline,
                          rightIcon: Icons.remove_red_eye_outlined),
                    );
                  }),
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
            )
          ],
        )));
  }
}
