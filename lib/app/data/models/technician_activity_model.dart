class TechnicianActivity {
  String? date;
  String? time;
  String? location;
  String? status;
  String? activity;
  String? description;

  TechnicianActivity(
      {this.date,
      this.time,
      this.location,
      this.status,
      this.activity,
      this.description});

  TechnicianActivity.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    location = json['location'];
    status = json['status'];
    activity = json['activity'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['status'] = status;
    data['activity'] = activity;
    data['description'] = description;
    return data;
  }
}
