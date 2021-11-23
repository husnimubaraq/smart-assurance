import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final AuthController authController = Get.find();
  var mainController = Get.put(MainController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> onRefressh() async {
    return Future.delayed(Duration(seconds: 2), () {
      fetchDetail();
    });
  }

  void fetchDetail() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
    };

    ProviderException response =
        await UserProvider().requestDetailProfile(body);

    if (response.status == "success") {
      mainController.user.value = response.data;
    } else {}
  }

  void onLogout() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
    };

    ProviderException response = await UserProvider().requestLogout(body);

    if (response.status == "success") {
      Fluttertoast.showToast(
          msg: response.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);

      authController.requestLogout();
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
