import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/modules/activity/controllers/map_presence_controller.dart';

class MapPresenceView extends GetView<MapPresenceController> {
  var _controller = Get.put(MapPresenceController());

  @override
  Widget build(BuildContext context) {
    var typePresence = Get.arguments;
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _controller.currentLocation.value,
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.mapController.complete(controller);
          },
        ),
      )),
      floatingActionButton: Obx(() {
        return FloatingActionButton.extended(
          elevation: 0,
          onPressed: typePresence == "checkin"
              ? _controller.isCurrentLocation.value
                  ? _controller.onStartLocator
                  : null
              : _controller.isCurrentLocation.value
                  ? _controller.onStopLocator
                  : null,
          label: Text(
            typePresence == "checkin" ? "Check In" : "Check Out",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14,
                color: kWhiteColor,
                fontWeight: FontWeight.w500),
          ),
          icon: null,
          backgroundColor: typePresence == "checkin"
              ? _controller.isCurrentLocation.value
                  ? Colors.lightBlue
                  : kPrimaryColor
              : _controller.isCurrentLocation.value
                  ? kDangerColor
                  : kDangerLightColor,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
