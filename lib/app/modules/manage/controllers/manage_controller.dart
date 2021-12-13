import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tracking/app/data/models/user_create_prepare_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/data/providers/user_provider.dart';
import 'package:tracking/app/helper/store.dart';

class Tabs {
  String key;
  String label;
  List<String> subTabs;

  Tabs(this.key, this.label, this.subTabs);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['label'] = this.label;
    data['subTabs'] = this.subTabs;
    return data;
  }
}

class ManageController extends GetxController {
  //TODO: Implement ManageController

  Completer<GoogleMapController> mapController = Completer();
  var currentLocation = LatLng(-7.8032076, 110.3573354).obs;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  Location location = new Location();

  List<User> rocUsers = [];

  // List<User> teamLeaderUsers = [];

  // List<User> teknisiUsers = [];

  final count = 0.obs;

  var teknisiUsers = <User>[].obs;
  var teamLeaderUsers = <User>[].obs;

  var summaryTeamLeader = "".obs;
  var summaryTeknisi = "".obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> onRefresh() async {
    return Future.delayed(Duration(seconds: 2), () {
      init();
    });
  }

  void init() async {
    User? user = await Store.getUser();
    String? sessionId = await Store.getSessionId();

    if (user?.userType == "ROC" || user?.userType == "SM") {
      Map<String, String> body = <String, String>{
        'session_id': sessionId != null ? sessionId : ""
      };

      ProviderException response = await GeneralrProvider().requestManage(body);

      if (response.status == "success") {
        if (response.data.listTeamLeader != null) {
          teamLeaderUsers.value = response.data.listTeamLeader;
        }
        summaryTeamLeader.value = response.data.summary.tEAMLEADER.toString();
        summaryTeknisi.value = response.data.summary.tEKNISI.toString();
      } else {}

      Map<String, String> body2 = <String, String>{
        'session_id': sessionId != null ? sessionId : "",
        "user_type": "TEKNISI",
        "upline_user_id": "",
        "keyword": "",
        "page": ""
      };

      ProviderException response2 = await UserProvider().requestList(body2);

      if (response2.status == "success") {
        teknisiUsers.value = response2.data.lists;
      } else {}
    } else {
      Map<String, String> body = <String, String>{
        'session_id': sessionId != null ? sessionId : "",
        'upline_user_id': user!.id.toString(),
      };

      ProviderException response =
          await GeneralrProvider().requestListTeknisi(body);

      if (response.status == "success") {
        teknisiUsers.value = response.data;

        if (response.data.length > 0) {
          for (int i = 0; i < teknisiUsers.length; i++) {
            if (teknisiUsers[i].dataDescription != null) {
              final String markerIdVal = 'marker_id_$i';
              final MarkerId markerId = MarkerId(markerIdVal);
              final Marker marker = Marker(
                  markerId: markerId,
                  infoWindow: InfoWindow(title: teknisiUsers[i].name),
                  position: new LatLng(
                      double.parse(teknisiUsers[i]
                          .dataDescription!
                          .activites!
                          .location!
                          .latitude!),
                      double.parse(teknisiUsers[i]
                          .dataDescription!
                          .activites!
                          .location!
                          .longitude!)),
                  icon: BitmapDescriptor.defaultMarker);
              markers[markerId] = marker;
            }
          }
        }
      } else {}
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
