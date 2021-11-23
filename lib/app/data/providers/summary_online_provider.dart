import 'package:get/get.dart';

import '../models/summary_online_model.dart';

class SummaryOnlineProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return SummaryOnline.fromJson(map);
      if (map is List)
        return map.map((item) => SummaryOnline.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<SummaryOnline?> getSummaryOnline(int id) async {
    final response = await get('summaryonline/$id');
    return response.body;
  }

  Future<Response<SummaryOnline>> postSummaryOnline(
          SummaryOnline summaryonline) async =>
      await post('summaryonline', summaryonline);
  Future<Response> deleteSummaryOnline(int id) async =>
      await delete('summaryonline/$id');
}
