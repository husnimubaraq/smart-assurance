import 'user_model.dart';

class UserAdminResponse {
  String? sessionId;
  User? user;
  Dashboard? dashboard;

  UserAdminResponse({this.sessionId, this.user, this.dashboard});

  UserAdminResponse.fromJson(Map<String, dynamic> json) {
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
  Users? users;

  Dashboard({this.notifications, this.users});

  Dashboard.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? Notifications?.fromJson(json['notifications'])
        : null;
    users = json['users'] != null ? Users?.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}

class Notifications {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<ListsNotifcation>? lists;
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
      lists = <ListsNotifcation>[];
      json['lists'].forEach((v) {
        lists!.add(ListsNotifcation.fromJson(v));
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

class ListsNotifcation {
  int? id;
  String? createdDate;
  int? userId;
  String? type;
  String? readStatus;
  dynamic readDatetime;
  String? title;
  String? message;
  dynamic targetUserId;

  ListsNotifcation(
      {this.id,
      this.createdDate,
      this.userId,
      this.type,
      this.readStatus,
      this.readDatetime,
      this.title,
      this.message,
      this.targetUserId});

  ListsNotifcation.fromJson(Map<String, dynamic> json) {
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

class Users {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<ListsUser>? lists;

  Users({this.totalData, this.currentPage, this.maxPage, this.lists});

  Users.fromJson(Map<String, dynamic> json) {
    totalData = json['total_data'];
    currentPage = json['current_page'];
    maxPage = json['max_page'];
    if (json['lists'] != null) {
      lists = <ListsUser>[];
      json['lists'].forEach((v) {
        lists!.add(ListsUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_data'] = totalData;
    data['current_page'] = currentPage;
    data['max_page'] = maxPage;
    if (lists != null) {
      data['lists'] = lists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListsUser {
  int? id;
  String? createdDate;
  String? userType;
  int? uplineUserId;
  String? nik;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? statusActive;
  String? updatedDate;
  String? statusPresensi;

  ListsUser(
      {this.id,
      this.createdDate,
      this.userType,
      this.uplineUserId,
      this.nik,
      this.name,
      this.email,
      this.phone,
      this.username,
      this.statusActive,
      this.updatedDate,
      this.statusPresensi});

  ListsUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['created_date'];
    userType = json['user_type'];
    uplineUserId = json['upline_user_id'];
    nik = json['nik'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    statusActive = json['status_active'];
    updatedDate = json['updated_date'];
    statusPresensi = json['status_presensi'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_date'] = createdDate;
    data['user_type'] = userType;
    data['upline_user_id'] = uplineUserId;
    data['nik'] = nik;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = username;
    data['status_active'] = statusActive;
    data['updated_date'] = updatedDate;
    data['status_presensi'] = statusPresensi;
    return data;
  }
}
