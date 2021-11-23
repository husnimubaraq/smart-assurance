import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/button/button_view.dart';
import '../../../helper/contants.dart';

import '../controllers/login_controller.dart';
import '../../../helper/size_config.dart';

class LoginView extends GetView<LoginController> {
  var _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                            top: getProportionateScreenHeight(50),
                            bottom: getProportionateScreenHeight(50)),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/app.png",
                              height: getProportionateScreenHeight(300),
                              width: getProportionateScreenWidth(300),
                            ),
                            Text(
                              "Smart Assurance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ],
                        )),
                  ]),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: 10),
                    child: TextFormField(
                      controller: _controller.email,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide.none),
                          focusColor: kWhiteColor,
                          filled: true,
                          prefixIcon: Icon(FeatherIcons.user),
                          fillColor: kWhiteColor,
                          hintText: 'Enter username',
                          labelText: "Username"),
                      style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                    ),
                  ),
                  Obx(() {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: 10),
                      child: TextFormField(
                        controller: _controller.password,
                        obscureText: _controller.passwordVisible.value == "true"
                            ? false
                            : true,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide.none),
                            focusColor: kWhiteColor,
                            filled: true,
                            prefixIcon: Icon(FeatherIcons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _controller.passwordVisible.value =
                                    _controller.passwordVisible.value == "true"
                                        ? "false"
                                        : "true";
                              },
                              icon: Icon(
                                  _controller.passwordVisible.value == "true"
                                      ? FeatherIcons.eyeOff
                                      : FeatherIcons.eye),
                            ),
                            fillColor: kWhiteColor,
                            hintText: 'Password',
                            labelText: "Password"),
                        style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: ButtonView(
                      label: "Masuk",
                      onTap: _controller.onLogin,
                      color: kWhiteColor,
                      backgroundColor: kPrimaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
