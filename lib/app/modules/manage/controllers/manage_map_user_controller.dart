import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:location_permissions/location_permissions.dart'
    as location_permissions;
import 'package:permission_handler/permission_handler.dart'
    as permision_handler;

class ManageMapUserController extends GetxController {
  Completer<GoogleMapController> mapController = Completer();
  var currentLocation = LatLng(-7.839379880239254, 110.31063106904612).obs;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Location location = new Location();

  List<User> teknisiUsers = [];

  @override
  void onInit() {
    // for (var i = 0; i < teknisiUsers.length; i++) {
    //   markers.add(Marker(
    //       markerId: MarkerId(teknisiUsers[i].id.toString()),
    //       position:
    //           LatLng(teknisiUsers[i].latitude!, teknisiUsers[i].longitude!),
    //       icon: BitmapDescriptor.defaultMarker,
    //       infoWindow: InfoWindow(title: teknisiUsers[i].alamat)));
    // }

    super.onInit();
    init();
  }

  void init() async {
    // var info = await DeviceInfoPlugin().androidInfo;
    // var sdkInt = info.version.sdkInt;
    // print("sdkInt: ${sdkInt}");
    // if (sdkInt >= 30) {
    //   var status = await askPermission();
    //   if (status.isGranted) {
    //     var locationResponse = await location.getLocation();

    //     currentLocation.value =
    //         LatLng(locationResponse.latitude!, locationResponse.longitude!);
    //     final GoogleMapController controller = await mapController.future;
    //     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(locationResponse.latitude!, locationResponse.longitude!),
    //       zoom: 14.4746,
    //     )));
    //   }
    // } else {
    //   print(await _checkLocationPermission());
    //   if (await _checkLocationPermission()) {
    //     var locationResponse = await location.getLocation();

    //     currentLocation.value =
    //         LatLng(locationResponse.latitude!, locationResponse.longitude!);
    //     final GoogleMapController controller = await mapController.future;
    //     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //       target:
    //           LatLng(locationResponse.latitude!, locationResponse.longitude!),
    //       zoom: 14.4746,
    //     )));
    //   }
    // }

    List<User> teknisiUsers = Get.arguments;

    List<LatLng> latLng = [];

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

  Future<bool> _checkLocationPermission() async {
    final access = await location_permissions.LocationPermissions()
        .checkPermissionStatus();
    switch (access) {
      case location_permissions.PermissionStatus.unknown:
      case location_permissions.PermissionStatus.denied:
      case location_permissions.PermissionStatus.restricted:
        final permission =
            await location_permissions.LocationPermissions().requestPermissions(
          permissionLevel:
              location_permissions.LocationPermissionLevel.locationAlways,
        );
        if (permission == location_permissions.PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
        break;
      case location_permissions.PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  Future<permision_handler.PermissionStatus> askPermission() async {
    permision_handler.Permission _permission =
        permision_handler.Permission.locationAlways;
    permision_handler.PermissionStatus _status = await _permission.request();
    if (_status.isDenied) {
      print('denied');
      var check = await openAppSettings();
      if (check) {
        Get.back();
      }
    }
    return _status;
  }
}
