import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/modules/manage/controllers/manage_map_user_controller.dart';

class ManageMapUserView extends GetView<ManageMapUserController> {
  var _controller = Get.put(ManageMapUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => GoogleMap(
          markers: Set<Marker>.of(_controller.markers.values),
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
    );
  }
}
