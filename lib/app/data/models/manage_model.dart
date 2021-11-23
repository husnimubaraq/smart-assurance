import 'package:tracking/app/data/models/user_model.dart';

class Manage {
  Summary? summary;
  List<User>? listTeamLeader;

  Manage({this.summary, this.listTeamLeader});

  Manage.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? Summary?.fromJson(json['summary']) : null;
    if (json['list_team_leader'] != null) {
      listTeamLeader = <User>[];
      json['list_team_leader'].forEach((v) {
        listTeamLeader!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (listTeamLeader != null) {
      data['list_team_leader'] =
          listTeamLeader!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? tEAMLEADER;
  int? tEKNISI;

  Summary({this.tEAMLEADER, this.tEKNISI});

  Summary.fromJson(Map<String, dynamic> json) {
    tEAMLEADER = json['TEAM LEADER'];
    tEKNISI = json['TEKNISI'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['TEAM LEADER'] = tEAMLEADER;
    data['TEKNISI'] = tEKNISI;
    return data;
  }
}

class ListTeamLeader {
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
  dynamic statusPresensi;
  dynamic distanceLocation;
  dynamic dataDescription;

  ListTeamLeader(
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

  ListTeamLeader.fromJson(Map<String, dynamic> json) {
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
    dataDescription = json['data_description'];
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
    data['data_description'] = dataDescription;
    return data;
  }
}
