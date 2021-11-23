import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/store.dart';

class ManageDetailUserController extends GetxController {
  //TODO: Implement ManageDetailUserController

  Completer<GoogleMapController> mapController = Completer();
  var currentLocation = LatLng(-7.8032076, 110.3573354).obs;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  Location location = new Location();

  var teknisiUsers = <User>[].obs;

  var selectedUserIndex = 0.obs;

  final count = 0.obs;
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
    User? user = Get.arguments;
    String? sessionId = await Store.getSessionId();

    Map<String, String> body = <String, String>{
      'session_id': sessionId != null ? sessionId : "",
      'upline_user_id': user!.id.toString(),
    };

    ProviderException response =
        await GeneralrProvider().requestListTeknisi(body);

    if (response.status == "success") {
      teknisiUsers.value = response.data;

      if (response.data.length > 0) {
        if (teknisiUsers[selectedUserIndex.value].dataDescription != null) {
          // currentLocation.value = LatLng(
          //     double.parse(teknisiUsers[selectedUserIndex.value]
          //         .dataDescription!
          //         .activites!
          //         .location!
          //         .latitude!),
          //     double.parse(teknisiUsers[selectedUserIndex.value]
          //         .dataDescription!
          //         .activites!
          //         .location!
          //         .longitude!));
          // final GoogleMapController controller = await mapController.future;
          // controller
          //     .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          //   target: LatLng(
          //       double.parse(teknisiUsers[selectedUserIndex.value]
          //           .dataDescription!
          //           .activites!
          //           .location!
          //           .latitude!),
          //       double.parse(teknisiUsers[selectedUserIndex.value]
          //           .dataDescription!
          //           .activites!
          //           .location!
          //           .longitude!)),
          //   zoom: 14.4746,
          // )));
        }

        for (int i = 0; i < teknisiUsers.length; i++) {
          if (teknisiUsers[i].dataDescription != null) {
            final String markerIdVal = 'marker_id_$i';
            final MarkerId markerId = MarkerId(markerIdVal);
            final Marker marker = Marker(
                onTap: () {
                  selectedUserIndex.value = i;
                },
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

  void onSelectUser(User user, int index) async {
    selectedUserIndex.value = index;

    if (user.dataDescription != null) {
      currentLocation.value = LatLng(
          double.parse(user.dataDescription!.activites!.location!.latitude!),
          double.parse(user.dataDescription!.activites!.location!.longitude!));
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            double.parse(user.dataDescription!.activites!.location!.latitude!),
            double.parse(
                user.dataDescription!.activites!.location!.longitude!)),
        zoom: 14.4746,
      )));
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
