import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tracking/app/data/models/technician_activity_model.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/models/user_teknisi_response_model.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/components/technician_item/technician_activity_item_view.dart';

class Filter {
  String label;
  String value;

  Filter({
    required this.label,
    required this.value,
  });
}

class LogActivityController extends GetxController {
  //TODO: Implement LogActivityController

  var dateSelected = DateTime.now().obs;

  var listActivities = <ListsActivity>[].obs;

  int page = 1;

  int? userIdSelected;
  String? filterSelected;

  var hasNextPage = true.obs;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  late ScrollController scrollController;

  var filters = <Filter>[
    new Filter(
        label: "Tanggal",
        value: DateFormat("yyyy-MM-dd").format(DateTime.now()) +
            " - " +
            DateFormat("yyyy-MM-dd").format(DateTime.now())),
    new Filter(label: "AKTIFITAS", value: "yes"),
    new Filter(label: "LOCATION", value: "yes"),
    new Filter(label: "PRESENSI", value: "yes")
  ].obs;

  var dateStart = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  var dateEnd = DateFormat("yyyy-MM-dd").format(DateTime.now()).obs;
  var filterAktifitas = "yes".obs;
  var filterLocation = "yes".obs;
  var filterPresensi = "yes".obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    init();
    scrollController = new ScrollController()..addListener(loadMore);
  }

  void onFilterDate(String startDate, String endDate) async {
    listActivities.clear();
    filters[0] =
        new Filter(label: "TANGGAL", value: startDate + " - " + endDate);
    dateStart.value = startDate;
    dateEnd.value = endDate;
    init();
    Get.back();
  }

  void onFilter(String value, int index) {
    listActivities.clear();
    filters[index] = new Filter(
        label: filters[index].label, value: value == "yes" ? "no" : "yes");
    if (index == 1) {
      filterAktifitas.value = value == "yes" ? "no" : "yes";
    }
    if (index == 2) {
      filterLocation.value = value == "yes" ? "no" : "yes";
    }
    if (index == 3) {
      filterPresensi.value = value == "yes" ? "no" : "yes";
    }
    init();
    Get.back();
  }

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      isLoadMoreRunning(true);

      page += 1;

      var params = Get.arguments;

      var id_user = params != null ? params["id_user"] : null;
      var filter = params != null ? params["filter"] : null;

      if (id_user != null && userIdSelected == null) {
        userIdSelected = id_user;
      } else if (id_user == null && userIdSelected != null) {
        id_user = userIdSelected;
      }

      User? user = await Store.getUser();
      String? sessionId = await Store.getSessionId();
      Map<String, String> body = <String, String>{
        'session_id': sessionId != null ? sessionId : "",
        'user_id': id_user != null ? id_user.toString() : user!.id.toString(),
        'filter[date][start_date]': dateStart.value,
        'filter[date][end_date]': dateEnd.value,
        'filter[type][AKTIFITAS]': (filter == "LOCATION" && filter != null)
            ? "no"
            : filterAktifitas.value,
        'filter[type][LOCATION]': filterLocation.value,
        'filter[type][PRESENSI]': (filter == "LOCATION" && filter != null)
            ? "no"
            : filterPresensi.value,
        'page': page.toString(),
      };

      ProviderException response =
          await ActivityProvider().requestListAcivity(body);

      if (response.status == "success") {
        if (response.data.lists.length > 0) {
          listActivities.addAll(response.data.lists);
        } else {
          hasNextPage(false);
        }
      } else {
        hasNextPage(false);
      }

      isLoadMoreRunning(false);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(loadMore);
    super.dispose();
  }

  void init() async {
    isFirstLoadRunning(true);

    var params = Get.arguments;

    var id_user = params != null ? params["id_user"] : null;
    var filter = params != null ? params["filter"] : null;

    if (filter == "LOCATION" && filter != null) {
      filterSelected = filter;
      filters[1] = new Filter(label: filters[1].label, value: "no");
      filters[3] = new Filter(label: filters[3].label, value: "no");
      filterAktifitas.value = "no";
      filterPresensi.value = "no";
    }

    if (id_user != null && userIdSelected == null) {
      userIdSelected = id_user;
    } else if (id_user == null && userIdSelected != null) {
      id_user = userIdSelected;
    }

    User? user = await Store.getUser();
    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'user_id': id_user != null ? id_user.toString() : user!.id.toString(),
      'filter[date][start_date]': dateStart.value,
      'filter[date][end_date]': dateEnd.value,
      'filter[type][AKTIFITAS]': (filter == "LOCATION" && filter != null)
          ? "no"
          : filterAktifitas.value,
      'filter[type][LOCATION]': filterLocation.value,
      'filter[type][PRESENSI]': (filter == "LOCATION" && filter != null)
          ? "no"
          : filterPresensi.value,
      'page': page.toString(),
    };

    ProviderException response =
        await ActivityProvider().requestListAcivity(body);

    if (response.status == "success") {
      listActivities.value = response.data.lists;
    } else {}
    isFirstLoadRunning(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
