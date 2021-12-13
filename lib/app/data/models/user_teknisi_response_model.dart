import 'package:tracking/app/data/models/user_model.dart';

import 'notifications_model.dart';

class UserTeknisiResponse {
  String? sessionId;
  User? user;
  Dashboard? dashboard;
  BaseUrl? baseUrl;
  Config? config;
  App? app;

  UserTeknisiResponse(
      {this.sessionId,
      this.baseUrl,
      this.config,
      this.app,
      this.user,
      this.dashboard});

  UserTeknisiResponse.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    dashboard = json['dashboard'] != null
        ? Dashboard?.fromJson(json['dashboard'])
        : null;
    this.baseUrl =
        json['base_url'] != null ? BaseUrl?.fromJson(json['base_url']) : null;
    this.config =
        json['config'] != null ? Config?.fromJson(json['config']) : null;
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
    if (config != null) {
      data['config'] = config!.toJson();
    }
    if (app != null) {
      data['app'] = app!.toJson();
    }
    if (baseUrl != null) {
      data['baseUrl'] = baseUrl!.toJson();
    }
    return data;
  }
}

class Dashboard {
  Notifications? notifications;
  Presensi? presensi;
  LastActivities? lastActivities;

  Dashboard({this.notifications, this.presensi, this.lastActivities});

  Dashboard.fromJson(Map<String, dynamic> json) {
    notifications = json['notifications'] != null
        ? Notifications?.fromJson(json['notifications'])
        : null;

    presensi =
        json['presensi'] != null ? Presensi?.fromJson(json['presensi']) : null;
    lastActivities = json['last_activities'] != null
        ? LastActivities?.fromJson(json['last_activities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.toJson();
    }
    if (presensi != null) {
      data['presensi'] = presensi!.toJson();
    }
    if (lastActivities != null) {
      data['last_activities'] = lastActivities!.toJson();
    }

    return data;
  }
}

class BaseUrl {
  String? image;

  BaseUrl({this.image});

  BaseUrl.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}

class Config {
  int? cronjobLogLocationTime;

  Config({this.cronjobLogLocationTime});

  Config.fromJson(Map<String, dynamic> json) {
    cronjobLogLocationTime = json['cronjob_log_location_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cronjob_log_location_time'] = cronjobLogLocationTime;
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

class Presensi {
  Checkin? checkin;
  Checkout? checkout;

  Presensi({this.checkin, this.checkout});

  Presensi.fromJson(Map<String, dynamic> json) {
    checkin =
        json['checkin'] != null ? Checkin?.fromJson(json['checkin']) : null;
    checkout =
        json['checkout'] != null ? Checkout?.fromJson(json['checkout']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (checkin != null) {
      data['checkin'] = checkin!.toJson();
    }
    if (checkout != null) {
      data['checkout'] = checkout!.toJson();
    }
    return data;
  }
}

class Checkin {
  String? status;
  String? datetime;

  Checkin({this.status, this.datetime});

  Checkin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['datetime'] = datetime;
    return data;
  }
}

class Checkout {
  String? status;
  dynamic datetime;

  Checkout({this.status, this.datetime});

  Checkout.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['datetime'] = datetime;
    return data;
  }
}

class LastActivities {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<ListsActivity>? lists;

  LastActivities({this.totalData, this.currentPage, this.maxPage, this.lists});

  LastActivities.fromJson(Map<String, dynamic> json) {
    totalData = json['total_data'];
    currentPage = json['current_page'];
    maxPage = json['max_page'];
    if (json['lists'] != null) {
      lists = <ListsActivity>[];
      json['lists'].forEach((v) {
        lists!.add(ListsActivity.fromJson(v));
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

class ListsActivity {
  int? id;
  String? createdDate;
  int? userId;
  String? type;
  String? category;
  String? longitude;
  String? latitude;
  String? address;
  String? imageUrl;
  String? catatan;
  dynamic dataDescription;

  ListsActivity(
      {this.id,
      this.createdDate,
      this.userId,
      this.type,
      this.category,
      this.longitude,
      this.latitude,
      this.address,
      this.imageUrl,
      this.catatan,
      this.dataDescription});

  ListsActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['created_date'];
    userId = json['user_id'];
    type = json['type'];
    category = json['category'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    address = json['address'];
    imageUrl = json['image_url'];
    catatan = json['catatan'];
    dataDescription = json['data_description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created_date'] = createdDate;
    data['user_id'] = userId;
    data['type'] = type;
    data['category'] = category;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['address'] = address;
    data['image_url'] = imageUrl;
    data['catatan'] = catatan;
    data['data_description'] = dataDescription;
    return data;
  }
}
