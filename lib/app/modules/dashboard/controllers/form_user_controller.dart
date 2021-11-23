import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_create_prepare_model.dart';
import 'package:tracking/app/data/models/user_list_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';

class FormUserController extends GetxController {
  //TODO: Implement FormUserController

  final DashboardController dashboardController = Get.find();

  final count = 0.obs;
  var userType = ["Pilih Tipe User"].obs;
  var userTypeValue = "Pilih Tipe User".obs;

  // late Future<List<UplineUserOptions>> uplines =
  //     Future<List<UplineUserOptions>>.delayed(
  //         const Duration(seconds: 2),
  //         () => [
  //               new UplineUserOptions(id: 0, name: "Pilih Upline", userType: "")
  //             ]);
  // var uplines = ["Pilih Upline"].obs;
  // var uplineValue = "Pilih Upline".obs;
  var uplines = <UplineUserOptions>[
    UplineUserOptions(id: 0, name: "Pilih Upline", userType: "")
  ].obs;
  var uplineValue = UplineUserOptions().obs;
  // late UplineUserOptions uplineValue =
  //     UplineUserOptions(id: 0, name: "Pilih Upline", userType: "");
  // var uplineValue =
  //     UplineUserOptions(id: 0, name: "Pilih Upline", userType: "").obs;

  // var loading = true;
  final Future<bool> loadingUserType =
      Future<bool>.delayed(const Duration(seconds: 2), () => false);
  final Future<bool> loadingUplines =
      Future<bool>.delayed(const Duration(seconds: 2), () => false);

  late TextEditingController name;
  late TextEditingController nik;
  late TextEditingController email;
  late TextEditingController phone;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    nik = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    init();
  }

  void init() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{'session_id': sessionId!};

    var resPrepareUser = await UserProvider().requestCreatePrepare(body);

    if (resPrepareUser.status == "success") {
      UserCreatePrepare userCreatePrepare = resPrepareUser.data;
      if (userCreatePrepare
              .userTypeOptions!.tEAMLEADER!.uplineUserOptions!.length >
          0) {
        userType.add("TEAM LEADER");
        uplineValue.value = uplines[0];
        // var test = pos;
        // positions.value = pos;
        // update();
      }
    }
  }

  void onChangeUserType(dynamic value) async {
    userTypeValue.value = value!;
    if (value == "TEAM LEADER") {
      String? sessionId = await Store.getSessionId();
      Map<String, String> body = <String, String>{
        'session_id': sessionId!,
        "user_type": value,
        "upline_user_id": "",
        "keyword": "",
        "page": ""
      };

      var resListUser = await UserProvider().requestList(body);
      UsersList listUser = resListUser.data;
      listUser.lists!.forEach((item) {
        uplines.add(new UplineUserOptions(
            id: item.id, name: item.name, userType: item.userType));
      });
    }
  }

  void onChangeUpline(dynamic value) {
    uplineValue.value = value;
    print(value.id);
  }

  void onSave() async {
    if (uplineValue.value.id == 0) {
      Fluttertoast.showToast(
          msg: "Upline belum diisi",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "user_type": "TEKNISI",
      "upline_user_id": uplineValue.value.id.toString(),
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
      // User resUser = resCreateUser.data;
      // var test = resUser;

      Fluttertoast.showToast(
          msg: resCreateUser.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);
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
