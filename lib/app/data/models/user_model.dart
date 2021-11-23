import 'dart:convert';

import 'package:tracking/app/data/models/user_data_description_user.dart';

class User {
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
  int? distanceLocation;
  DataDescription? dataDescription;

  User(
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
      this.statusPresensi,
      this.distanceLocation,
      this.dataDescription});

  User.fromJson(Map<String, dynamic> json) {
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
    distanceLocation = json['distance_location'];
    dataDescription = json['data_description'] != null
        ? DataDescription?.fromJson(jsonDecode(json['data_description']))
        : null;
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
    data['distance_location'] = distanceLocation;
    if (dataDescription != null) {
      data['data_description'] = dataDescription!.toJson();
    }
    return data;
  }
}
