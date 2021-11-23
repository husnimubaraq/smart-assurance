import 'package:tracking/app/data/models/user_model.dart';

class SummaryOnline {
  List<User>? success;
  List<User>? waiting;

  SummaryOnline({this.success, this.waiting});

  SummaryOnline.fromJson(Map<String, dynamic> json) {
    if (json['success'] != null) {
      success = <User>[];
      json['success'].forEach((v) {
        success!.add(User.fromJson(v));
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
    if (success != null) {
      data['success'] = success!.map((v) => v.toJson()).toList();
    }
    if (waiting != null) {
      data['waiting'] = waiting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
