import 'dart:convert';

import 'package:tracking/app/data/models/user_data_description_user.dart';

import 'notifications_model.dart';
import 'user_model.dart';

class UserRocLeaderResponse {
  String? sessionId;
  User? user;
  Dashboard? dashboard;
  App? app;

  UserRocLeaderResponse({this.sessionId, this.user, this.dashboard, this.app});

  UserRocLeaderResponse.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    dashboard = json['dashboard'] != null
        ? Dashboard?.fromJson(json['dashboard'])
        : null;
    this.app = json['app'] != null ? App?.fromJson(json['app']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['session_id'] = sessionId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    if (app != null) {
      data['app'] = app!.toJson();
    }
    return data;
  }
}

class Dashboard {
  Notifications? notifications;
  Presence? presence;
  OnlineStatus? onlineStatus;
  List<User>? idleUsers;

  Dashboard(
      {this.notifications, this.presence, this.onlineStatus, this.idleUsers});

  Dashboard.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? Notifications?.fromJson(json['notifications'])
        : null;
    presence =
        json['presence'] != null ? Presence?.fromJson(json['presence']) : null;
    onlineStatus = json['online_status'] != null
        ? OnlineStatus?.fromJson(json['online_status'])
        : null;
    if (json['idle_users'] != null) {
      idleUsers = <User>[];
      json['idle_users'].forEach((v) {
        idleUsers!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    if (presence != null) {
      data['presence'] = presence!.toJson();
    }
    if (onlineStatus != null) {
      data['online_status'] = onlineStatus!.toJson();
    }
    if (idleUsers != null) {
      data['idle_users'] = idleUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class App {
  String? version;
  String? urlDownload;

  App({this.version, this.urlDownload});

  App.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    urlDownload = json['url_download'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['url_download'] = urlDownload;
    return data;
  }
}

class Presence {
  int? success;
  int? waiting;

  Presence({this.success, this.waiting});

  Presence.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    waiting = json['waiting'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['waiting'] = waiting;
    return data;
  }
}

class OnlineStatus {
  int? success;
  int? waiting;

  OnlineStatus({this.success, this.waiting});

  OnlineStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    waiting = json['waiting'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    data['waiting'] = waiting;
    return data;
  }
}

class IdleUsers {
  int? id;
  String? userType;
  String? name;
  int? distanceLocation;
  DataDescription? dataDescription;

  IdleUsers(
      {this.id,
      this.userType,
      this.name,
      this.distanceLocation,
      this.dataDescription});

  IdleUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    name = json['name'];
    distanceLocation = json['distance_location'];
    dataDescription = json['data_description'] != null
        ? DataDescription?.fromJson(jsonDecode(json['data_description']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['name'] = name;
    data['distance_location'] = distanceLocation;
    if (dataDescription != null) {
      data['data_description'] = dataDescription!.toJson();
    }
    return data;
  }
}
