class TechnicianPresence {
  String? date;
  String? time;
  String? location;
  String? status;

  TechnicianPresence({this.date, this.time, this.location, this.status});

  TechnicianPresence.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    location = json['location'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    data['status'] = status;
    return data;
  }
}
