import 'dart:convert';

import 'package:get/get.dart';
import 'package:tracking/app/data/models/response_model.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_create_prepare_model.dart';
import 'package:tracking/app/data/models/user_detail_model.dart';
import 'package:tracking/app/data/models/user_list_model.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'provider.dart';
import '../models/user_model.dart';

class UserProvider extends Provider {
  Future<dynamic> requestLogin(Map<String, String> body) async {
    String res = await this.getRequest("authentication/login", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    String userType = response["data"]["user"]["user_type"];

    if (userType == USER_TEKNISI) {
      return UserTeknisiResponse.fromJson(response["data"]);
    } else if (userType == USER_ROC) {
      return UserRocLeaderResponse.fromJson(response["data"]);
    } else if (userType == USER_TEAMLEADER) {
      return UserRocLeaderResponse.fromJson(response["data"]);
    } else if (userType == USER_ADMIN) {
      return UserAdminResponse.fromJson(response["data"]);
    }

    return ProviderException(message: "User type not found", status: "failed");
  }

  Future<ProviderException> requestLogout(Map<String, String> body) async {
    String res = await this.getRequest("authentication/logout", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestCreatePrepare(
      Map<String, String> body) async {
    String res = await this.getRequest("user/prepare-create-user", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "Success",
        status: status,
        data: UserCreatePrepare.fromJson(response["data"]));
  }

  Future<ProviderException> requestList(Map<String, String> body) async {
    String res = await this.getRequest("user/list-user", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "Success",
        status: status,
        data: UsersList.fromJson(response["data"]));
  }

  Future<ProviderException> requestCreateUser(Map<String, String> body) async {
    String res = await this.getRequest("user/create-user", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestEditProfile(Map<String, String> body) async {
    String res = await this.getRequest("profile/edit", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestChangePassword(
      Map<String, String> body) async {
    String res = await this.getRequest("profile/change-password", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestDeleteUser(Map<String, String> body) async {
    String res = await this.getRequest("user/delete-user", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestResetPassword(
      Map<String, String> body) async {
    String res = await this.getRequest("user/reset-password", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: response["message"], status: status, data: null);
  }

  Future<ProviderException> requestDetailProfile(
      Map<String, String> body) async {
    String res = await this.getRequest("profile/get-profile", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "Success",
        status: status,
        data: User.fromJson(response["data"]["user"]));
  }

  Future<ProviderException> requestDetailUser(Map<String, String> body) async {
    String res = await this.getRequest("user/detail-user", body);

    Map<String, dynamic> response = jsonDecode(res);
    String status = response['status'];

    if (status == "failed") {
      return ProviderException(message: response["message"], status: status);
    }

    return ProviderException(
        message: "Success",
        status: status,
        data: UserDetail.fromJson(response["data"]));
  }
}
