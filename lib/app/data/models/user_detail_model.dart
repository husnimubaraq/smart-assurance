import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';

class UserDetail {
  User? user;
  Manage? manage;

  UserDetail({this.user, this.manage});

  UserDetail.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    manage = json['manage'] != null ? Manage?.fromJson(json['manage']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (manage != null) {
      data['manage'] = manage!.toJson();
    }
    return data;
  }
}

class Manage {
  Presensi? presensi;
  LastActivities? lastActivities;

  Manage({this.presensi, this.lastActivities});

  Manage.fromJson(Map<String, dynamic> json) {
    presensi =
        json['presensi'] != null ? Presensi?.fromJson(json['presensi']) : null;
    lastActivities = json['last_activities'] != null
        ? LastActivities?.fromJson(json['last_activities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (presensi != null) {
      data['presensi'] = presensi!.toJson();
    }
    if (lastActivities != null) {
      data['last_activities'] = lastActivities!.toJson();
    }
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
