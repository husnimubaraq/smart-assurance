import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController

  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;

  final visibleOldPassword = "true".obs;
  final visibleNewPassword = "true".obs;
  final visibleConfirmPassword = "true".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();
  }

  void onSave() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "old_password": oldPassword.text,
      "new_password": newPassword.text,
      "confirm_new_password": confirmPassword.text
    };

    var resCreateUser = await UserProvider().requestChangePassword(body);
    if (resCreateUser.status == "failed") {
      Fluttertoast.showToast(
          msg: resCreateUser.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: resCreateUser.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
