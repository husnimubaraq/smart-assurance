import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/manage/controllers/manage_controller.dart';

class ManageFormUserController extends GetxController {
  final ManageController manageController = Get.find();
  final DashboardController dashboardController = Get.find();
  //TODO: Implement ManageFormUserController

  late TextEditingController name;
  late TextEditingController nik;
  late TextEditingController email;
  late TextEditingController phone;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    nik = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
  }

  void onSave() async {
    User? user = await Store.getUser();
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "user_type": user!.userType == "ROC" ? "TEAM LEADER" : "TEKNISI",
      "upline_user_id": user.id.toString(),
      "nik": nik.text,
      "name": name.text,
      "email": email.text,
      "phone": phone.text
    };

    var resCreateUser = await UserProvider().requestCreateUser(body);
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
      manageController.init();
      dashboardController.fetchData("");
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
