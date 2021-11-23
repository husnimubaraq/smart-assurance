class ResponseModel {
  String? status;
  dynamic data;

  ResponseModel({this.status, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = data;
    return data;
  }
}
