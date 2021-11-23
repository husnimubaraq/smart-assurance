class Technician {
  String? name;
  String? date;
  String? time;
  String? location;

  Technician({this.name, this.date, this.time, this.location});

  Technician.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    time = json['time'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['date'] = date;
    data['time'] = time;
    data['location'] = location;
    return data;
  }
}
