import 'package:tracking/app/data/models/user_model.dart';

class UsersList {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<User>? lists;

  UsersList({this.totalData, this.currentPage, this.maxPage, this.lists});

  UsersList.fromJson(Map<String, dynamic> json) {
    totalData = json['total_data'];
    currentPage = json['current_page'];
    maxPage = json['max_page'];
    if (json['lists'] != null) {
      lists = <User>[];
      json['lists'].forEach((v) {
        lists!.add(User.fromJson(v));
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
