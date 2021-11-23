import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';

import 'login_state.dart';

class LoginController extends GetxController {
  var mainController = Get.put(MainController());
  final AuthController authController = Get.find();

  final _loginStateStream = LoginState().obs;
  LoginState get state => _loginStateStream.value;

  late TextEditingController email;
  late TextEditingController password;
  final passwordVisible = "false".obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    // email.text = "085696811483";
    // password.text = "12345678";
  }

  void onLogin() async {
    String? token = await Store.getToken();
    _loginStateStream.value = LoginLoading();

    if (email.text == "") {
      _loginStateStream.value = LoginFailure(error: "Email belum diisi");

      Fluttertoast.showToast(
          msg: "Email belum diisi",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else if (password.text == "") {
      _loginStateStream.value = LoginFailure(error: "Password belum diisi");

      Fluttertoast.showToast(
          msg: "Password belum diisi",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      Map<String, String> body = <String, String>{
        // 'username': "085696811483",
        'username': email.text,
        // 'password': "12345678",
        'password': password.text,
        'fcm_token': token!
      };

      ProviderException response = await authController.requestLogin(body);

      if (response.status == "failed") {
        _loginStateStream.value = LoginFailure(error: response.message);
        Fluttertoast.showToast(
            msg: response.message,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: kDangerColor,
            toastLength: Toast.LENGTH_LONG);
      } else {
        _loginStateStream.value = LoginState();
        email.text = "";
        password.text = "";
        // Get.offAllNamed(Routes.MAIN);
      }
    }
  }
}
