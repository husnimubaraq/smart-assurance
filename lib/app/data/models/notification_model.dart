class Notification {
  String? title;
  String? description;
  String? date;

  Notification({this.title, this.description, this.date});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    return data;
  }
}
