import 'package:tracking/app/data/models/user_model.dart';

class SummaryPresence {
  List<User>? checkin;
  List<User>? waiting;

  SummaryPresence({this.checkin, this.waiting});

  SummaryPresence.fromJson(Map<String, dynamic> json) {
    if (json['checkin'] != null) {
      checkin = <User>[];
      json['checkin'].forEach((v) {
        checkin!.add(User.fromJson(v));
      });
    }
    if (json['waiting'] != null) {
      waiting = <User>[];
      json['waiting'].forEach((v) {
        waiting!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (checkin != null) {
      data['checkin'] = checkin!.map((v) => v.toJson()).toList();
    }
    if (waiting != null) {
      data['waiting'] = waiting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
