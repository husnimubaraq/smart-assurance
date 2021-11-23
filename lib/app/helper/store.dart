import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart'
    as UserAdmin;
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart'
    as UserRocLeader;
import 'package:tracking/app/data/models/user_teknisi_response_model.dart'
    as UserTeknisi;
import 'dart:convert';

import 'package:tracking/app/data/models/user_model.dart';

class Store {
  static void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static void saveSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("sessionId", sessionId);
  }

  static Future<String?> getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('sessionId');
  }

  static void deleteSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionId');
  }

  static void saveIsTracking(String tracking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tracking", tracking);
  }

  static Future<String?> getIsTracking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tracking');
  }

  static void deleteIsTracking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('tracking');
  }

  static void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(user));
  }

  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString('user') ?? "";

    User user;
    if (userJson == "") {
      return null;
    }

    Map<String, dynamic> responseUser = json.decode(userJson);
    user = User.fromJson(responseUser);

    return user;
  }

  static void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static void saveDashboard(dynamic dashboard) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("dashboard", json.encode(dashboard));
  }

  static Future<dynamic> getDashboard(String? userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dashboardJson = prefs.getString('dashboard') ?? "";

    dynamic dashboard;
    if (dashboardJson == "") {
      return null;
    }

    Map<String, dynamic> responseDashboard = json.decode(dashboardJson);
    if (userType == "ADMIN") {
      dashboard = UserAdmin.Dashboard.fromJson(responseDashboard);
    } else if (userType == "ROC") {
      dashboard = UserRocLeader.Dashboard.fromJson(responseDashboard);
    } else if (userType == "TEAM LEADER") {
      dashboard = UserRocLeader.Dashboard.fromJson(responseDashboard);
    } else if (userType == "TEKNISI") {
      dashboard = UserTeknisi.Dashboard.fromJson(responseDashboard);
    } else {
      return null;
    }

    return dashboard;
  }

  static void deleteDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('dashboard');
  }
}
