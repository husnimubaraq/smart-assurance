import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/controller/auth_state.dart';
import 'package:tracking/app/modules/login/views/login_view.dart';
import 'package:tracking/app/modules/main/views/main_view.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  var _controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (_controller.state is UnAuth) {
        return LoginView();
      }
      if (_controller.state is Authenticated) {
        return MainView();
      }
      return SafeArea(
          child: Column(
        children: [Expanded(flex: 1, child: Text(""))],
      ));
    }));
  }
}
