import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tracking/app/data/models/user_detail_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';

class DashboardDetailTeknisiController extends GetxController {
  //TODO: Implement DashboardDetailTeknisiController

  var listActivities = <ListsActivity>[].obs;
  var detailUser = User(email: "", phone: "", nik: "").obs;
  var checkIn = Checkin(status: null, datetime: null).obs;
  var checkOut = Checkout(status: null, datetime: null).obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    requestDetailUser();
    // init();
  }

  Future<void> onRefresh() async {
    return Future.delayed(Duration(seconds: 2), () {
      requestDetailUser();
      // init();
    });
  }

  void requestDetailUser() async {
    User user = Get.arguments;

    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'user_id': user.id.toString()
    };

    ProviderException response = await UserProvider().requestDetailUser(body);

    if (response.status == "success") {
      UserDetail userDetail = response.data;
      detailUser.value = userDetail.user!;

      checkIn.value = userDetail.manage!.presensi!.checkin!;
      checkOut.value = userDetail.manage!.presensi!.checkout!;

      listActivities.value = userDetail.manage!.lastActivities!.lists!;
    } else {}
  }

  void init() async {
    User user = Get.arguments;

    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'user_id': user.id.toString(),
      'filter[date][start_date]': '2021-10-26',
      'filter[date][end_date]': DateFormat("yyyy-MM-dd").format(DateTime.now()),
      'filter[type][AKTIFITAS]': 'yes',
      'filter[type][LOCATION]': 'yes',
      'filter[type][PRESENSI]': 'yes',
      'page': '1'
    };

    ProviderException response =
        await ActivityProvider().requestListAcivity(body);

    if (response.status == "success") {
      listActivities.value = response.data.lists;
    } else {}
  }

  void sendRequestActivity() async {
    User user = Get.arguments;

    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "user_id": user.id.toString(),
    };

    ProviderException responseAddPresence =
        await ActivityProvider().requestSendActivity(body);

    if (responseAddPresence.status == "failed") {
      Fluttertoast.showToast(
          msg: responseAddPresence.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: responseAddPresence.message,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kSuccessColor,
          toastLength: Toast.LENGTH_LONG);
    }
  }
}
