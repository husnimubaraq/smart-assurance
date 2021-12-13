import 'dart:convert';

import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'provider.dart';

class ActivityProvider extends Provider {
  final AuthController authController = Get.find();

  Future<ProviderException> requestListAcivity(Map<String, String> body) async {
    String res = await this.getRequest("activities/list-activities", body);

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
        data: LastActivities.fromJson(response["data"]));
  }

  Future<ProviderException> requestAddPresence(Map<String, String> body) async {
    String res = await this.getRequest("activities/add-presence", body);

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
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestAddActivity(Map<String, String> body,
      {String path: "", String pathBody: ""}) async {
    String res = await this.getRequest("activities/add-activity", body,
        path: path, pathBody: pathBody);

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
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestSendActivity(Map<String, String> body,
      {String path: "", String pathBody: ""}) async {
    String res = await this.getRequest("activities/request-activity", body,
        path: path, pathBody: pathBody);

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
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestAddLoction(Map<String, String> body) async {
    String res = await this.getRequest("activities/add-location", body);

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
        message: response["message"], status: status, data: null);
  }
}
