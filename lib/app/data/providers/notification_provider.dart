import 'dart:convert';

import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/data/models/notifications_model.dart'
    as notifikasi;
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'provider.dart';

class NotificationProvider extends Provider {
  final AuthController authController = Get.find();

  Future<ProviderException> requestListNotification(
      Map<String, String> body) async {
    String res = await this.getRequest("notification/list-notification", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    if (status == "error") {
      authController.requestLogout();
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "",
        status: "success",
        data: notifikasi.Notifications.fromJson(response["data"]));
  }

  Future<ProviderException> requestDetailtNotification(
      Map<String, String> body) async {
    String res = await this.getRequest("notification/get-notification", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    if (status == "error") {
      authController.requestLogout();
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "",
        status: "success",
        data: notifikasi.ListsNotification.fromJson(response["data"]));
  }
}
