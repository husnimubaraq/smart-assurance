class Notifications {
  int? totalData;
  int? currentPage;
  int? maxPage;
  List<ListsNotification>? lists;
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
    totalUnread = json['total_unread'];
    maxPage = json['max_page'];
    if (json['lists'] != null) {
      lists = <ListsNotification>[];
      json['lists'].forEach((v) {
        lists!.add(ListsNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_data'] = totalData;
    data['current_page'] = currentPage;
    data['total_unread'] = totalUnread;
    data['max_page'] = maxPage;
    if (lists != null) {
      data['lists'] = lists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListsNotification {
  int? id;
  String? createdDate;
  int? userId;
  String? type;
  String? readStatus;
  String? readDatetime;
  String? title;
  String? message;
  int? targetUserId;

  ListsNotification(
      {this.id,
      this.createdDate,
      this.userId,
      this.type,
      this.readStatus,
      this.readDatetime,
      this.title,
      this.message,
      this.targetUserId});

  ListsNotification.fromJson(Map<String, dynamic> json) {
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
