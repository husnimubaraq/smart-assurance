import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/profile/controllers/profile_controller.dart';

class ChangeProfileController extends GetxController {
  //TODO: Implement ChangeProfileController

  var profileController = Get.put(ProfileController());

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();

    User user = Get.arguments;
    name.text = user.name!;
    email.text = user.email!;
    phone.text = user.phone!;
  }

  void onSave() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "name": name.text,
      "email": email.text,
      "phone": phone.text
    };

    var resCreateUser = await UserProvider().requestEditProfile(body);
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
      profileController.fetchDetail();
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
