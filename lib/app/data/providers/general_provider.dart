import 'dart:convert';

import 'package:get/get.dart';
import 'package:tracking/app/controller/auth_controller.dart';
import 'package:tracking/app/data/models/get_address_model.dart';
import 'package:tracking/app/data/models/manage_model.dart';
import 'package:tracking/app/data/models/response_model.dart';
import 'package:tracking/app/data/models/summary_online_model.dart';
import 'package:tracking/app/data/models/summary_presence_model.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'provider.dart';
import '../models/user_model.dart';

class GeneralrProvider extends Provider {
  final AuthController authController = Get.find();
  Future<ProviderException> requestDashboard(Map<String, String> body) async {
    String res = await this.getRequest("general/dashboard", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    if (status == "error") {
      authController.requestLogout();
      return ProviderException(message: response["message"], status: status);
    }

    String userType = response["data"]["user"]["user_type"];

    if (userType == USER_TEKNISI) {
      // return UserTeknisiResponse.fromJson(response["data"]);
      return ProviderException(
          message: "Success",
          status: "success",
          data: UserTeknisiResponse.fromJson(response["data"]));
    } else if (userType == USER_ROC) {
      // return UserRocLeaderResponse.fromJson(response["data"]);
      return ProviderException(
          message: "Success",
          status: "success",
          data: UserRocLeaderResponse.fromJson(response["data"]));
    } else if (userType == USER_SM) {
      // return UserRocLeaderResponse.fromJson(response["data"]);
      return ProviderException(
          message: "Success",
          status: "success",
          data: UserRocLeaderResponse.fromJson(response["data"]));
    } else if (userType == USER_TEAMLEADER) {
      // return UserRocLeaderResponse.fromJson(response["data"]);
      return ProviderException(
          message: "Success",
          status: "success",
          data: UserRocLeaderResponse.fromJson(response["data"]));
    } else if (userType == USER_ADMIN) {
      // return UserAdminResponse.fromJson(response["data"]);
      return ProviderException(
          message: "Success",
          status: "success",
          data: UserAdminResponse.fromJson(response["data"]));
    }

    return ProviderException(message: "User type not found", status: "failed");
  }

  Future<List<GetAddress>> requestGetAddress(
      double latitude, double longitude) async {
    var response = await get(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude}, ${longitude}&key=AIzaSyCGO2ORkn1GJgPIZBcT1HuOQ-r7bu9ZMD8&language=ID');

    String status = response.body["status"];
    if (status == "OK") {
      var results = <GetAddress>[];
      response.body["results"].forEach((v) {
        results.add(GetAddress.fromJson(v));
      });
      return results;
    }

    return [];
  }

  Future<ProviderException> requestListTeknisi(Map<String, String> body) async {
    String res = await this.getRequest("general/get-list-teknisi", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    if (status == "error") {
      authController.requestLogout();
      return ProviderException(message: response["message"], status: status);
    }

    var results = <User>[];
    if (response["data"] != null) {
      response["data"].forEach((v) {
        results.add(User.fromJson(v));
      });
    }

    return ProviderException(message: "", status: "success", data: results);
  }

  Future<ProviderException> requestSummaryPresence(
      Map<String, String> body) async {
    String res = await this.getRequest("general/get-summary-presence", body);

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
        data: SummaryPresence.fromJson(response["data"]));
  }

  Future<ProviderException> requestSummaryOnline(
      Map<String, String> body) async {
    String res = await this.getRequest("general/get-summary-online", body);

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
        data: SummaryOnline.fromJson(response["data"]));
  }

  Future<ProviderException> requestManage(Map<String, String> body) async {
    String res = await this.getRequest("general/manage", body);

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
        data: Manage.fromJson(response["data"]["manage"]));
  }
}
