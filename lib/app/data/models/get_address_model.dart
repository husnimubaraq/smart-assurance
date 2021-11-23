class GetAddress {
  String? formattedAddress;

  GetAddress({this.formattedAddress});

  GetAddress.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['formatted_address'] = formattedAddress;
    return data;
  }
}
