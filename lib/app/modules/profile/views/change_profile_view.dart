import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/profile/controllers/change_profile_controller.dart';
import 'package:tracking/components/button/button_view.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/input/input_item_view.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  var _controller = Get.put(ChangeProfileController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(
            title: "Ubah Profil",
            separator: false,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1))),
                  child: InputItemView(
                    controller: _controller.name,
                    label: "Nama",
                    hint: "Masukan Nama",
                    value: "Masukan Nama",
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1))),
                  child: InputItemView(
                      controller: _controller.email,
                      keyboardEmail: true,
                      label: "Email",
                      hint: "Masukan Email",
                      value: "Email"),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.black12, width: 1))),
                  child: InputItemView(
                      controller: _controller.phone,
                      keyboardNumber: true,
                      label: "Phone",
                      hint: "Masukan Phone",
                      value: "Phone"),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
      )),
    );
  }
}
