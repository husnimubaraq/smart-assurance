import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/manage/controllers/manage_form_user_controller.dart';
import 'package:tracking/components/button/button_view.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/input/input_default_view.dart';

class ManageFormUserView extends GetView<ManageFormUserController> {
  var _controller = Get.put(ManageFormUserController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
        child: Column(
          children: [
            HeaderView(
              title: "Tambah user",
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
                ))
          ],
        ),
      ),
    );
  }
}
