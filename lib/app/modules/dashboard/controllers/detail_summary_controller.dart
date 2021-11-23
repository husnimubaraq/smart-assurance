import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/store.dart';

class DetailSummaryController extends GetxController {
  //TODO: Implement DetailSummaryController

  var listCheckIn = <User>[].obs;
  var listCheckOut = <User>[].obs;

  var listOnline = <User>[].obs;
  var listOffline = <User>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    String typeSummary = Get.arguments;
    if (typeSummary == "presence") {
      initSummaryPresence();
    } else {
      initSummaryOnline();
    }
  }

  Future<void> onRefresh() async {
    return Future.delayed(Duration(seconds: 2), () {
      String typeSummary = Get.arguments;
      if (typeSummary == "presence") {
        initSummaryPresence();
      } else {
        initSummaryOnline();
      }
    });
  }

  void initSummaryPresence() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : ""
    };

    ProviderException response =
        await GeneralrProvider().requestSummaryPresence(body);

    if (response.status == "success") {
      listCheckIn.value = response.data.checkin;
      listCheckOut.value = response.data.waiting;
    } else {}
  }

  void initSummaryOnline() async {
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : ""
    };

    ProviderException response =
        await GeneralrProvider().requestSummaryOnline(body);

    if (response.status == "success") {
      listOnline.value = response.data.success;
      listOffline.value = response.data.waiting;
    } else {}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
