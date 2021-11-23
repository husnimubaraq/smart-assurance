import 'dart:convert';

import 'package:tracking/app/data/models/user_data_description_user.dart';

import 'user_model.dart';

class UserRocLeaderResponse {
  String? sessionId;
  User? user;
  Dashboard? dashboard;

  UserRocLeaderResponse({this.sessionId, this.user, this.dashboard});

  UserRocLeaderResponse.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    dashboard = json['dashboard'] != null
        ? Dashboard?.fromJson(json['dashboard'])
        : null;
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

class Notifications {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<Lists>? lists;
  int? totalUnread;

  Notifications(
      {this.totalData,
      this.currentPage,
      this.maxPage,
      this.lists,
      this.totalUnread});

  Notifications.fromJson(Map<String, dynamic> json) {
    totalData = json['total_data'];
    currentPage = json['current_page'];
    maxPage = json['max_page'];
    if (json['lists'] != null) {
      lists = <Lists>[];
      json['lists'].forEach((v) {
        lists!.add(Lists.fromJson(v));
      });
    }
    totalUnread = json['total_unread'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_data'] = totalData;
    data['current_page'] = currentPage;
    data['max_page'] = maxPage;
    if (lists != null) {
      data['lists'] = lists!.map((v) => v.toJson()).toList();
    }
    data['total_unread'] = totalUnread;
    return data;
  }
}

class Lists {
  int? id;
  String? createdDate;
  int? userId;
  String? type;
  String? readStatus;
  String? readDatetime;
  String? title;
  String? message;
  dynamic targetUserId;

  Lists(
      {this.id,
      this.createdDate,
      this.userId,
      this.type,
      this.readStatus,
      this.readDatetime,
      this.title,
      this.message,
      this.targetUserId});

  Lists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['created_date'];
    userId = json['user_id'];
    type = json['type'];
    readStatus = json['read_status'];
    readDatetime = json['read_datetime'];
    title = json['title'];
    message = json['message'];
    targetUserId = json['target_user_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_date'] = createdDate;
    data['user_id'] = userId;
    data['type'] = type;
    data['read_status'] = readStatus;
    data['read_datetime'] = readDatetime;
    data['title'] = title;
    data['message'] = message;
    data['target_user_id'] = targetUserId;
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
