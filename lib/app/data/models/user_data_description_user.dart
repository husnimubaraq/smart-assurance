class DataDescription {
  Activities? activites;

  DataDescription({this.activites});

  DataDescription.fromJson(Map<String, dynamic> json) {
    activites = json['activites'] != null
        ? Activities?.fromJson(json['activites'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (activites != null) {
      data['activites'] = activites!.toJson();
    }
    return data;
  }
}

class Activities {
  Location? location;

  Activities({this.location});

  Activities.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location?.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (location != null) {
      data['presence'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? createdDate;
  String? longitude;
  String? latitude;

  Location({this.createdDate, this.longitude, this.latitude});

  Location.fromJson(Map<String, dynamic> json) {
    createdDate = json['created_date'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['created_date'] = createdDate;
    data['longitude'] = longitude;
    data['latitude'] = longitude;
    return data;
  }
}
