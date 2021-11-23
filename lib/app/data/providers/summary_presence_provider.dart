import 'package:get/get.dart';

import '../models/summary_presence_model.dart';

class SummaryPresenceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SummaryPresence.fromJson(map);
      if (map is List)
        return map.map((item) => SummaryPresence.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SummaryPresence?> getSummaryPresence(int id) async {
    final response = await get('summarypresence/$id');
    return response.body;
  }

  Future<Response<SummaryPresence>> postSummaryPresence(
          SummaryPresence summarypresence) async =>
      await post('summarypresence', summarypresence);
  Future<Response> deleteSummaryPresence(int id) async =>
      await delete('summarypresence/$id');
}
