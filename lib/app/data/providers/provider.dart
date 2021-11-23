import 'package:tracking/app/helper/contants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Provider extends GetConnect {
  Future<String> getRequest(String url, Map<String, String> body,
      {String path: "", String pathBody: ""}) async {
    Map<String, String> headers = <String, String>{
      'Authorization': Authorization
    };

    var uri = Uri.parse(BaseUrl + url);

    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(body);

    if (path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(pathBody, path));
    }
    var res = await request.send();
    String response = await res.stream.bytesToString();

    return response;
  }
}

class ProviderException implements Exception {
  final String message;
  final String status;
  final dynamic data;

  ProviderException(
      {this.message = 'Unknown error occurred. ',
      this.status = "failed",
      this.data = null});
}
