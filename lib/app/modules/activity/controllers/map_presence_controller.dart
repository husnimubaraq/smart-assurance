import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/file_manager.dart';
import 'package:tracking/app/helper/location_callback_handler.dart';
import 'package:tracking/app/helper/location_service_repository.dart';
import 'package:location_permissions/location_permissions.dart'
    as location_permissions;
import 'package:tracking/app/helper/store.dart';
import 'package:permission_handler/permission_handler.dart'
    as permision_handler;
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:device_info/device_info.dart';

class MapPresenceController extends GetxController {
  final DashboardController dashboardController = Get.find();
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool isRunning = false;
  LocationDto? lastLocation = null;
  Location location = new Location();
  var isCurrentLocation = false.obs;

  Completer<GoogleMapController> mapController = Completer();
  var currentLocation = LatLng(-7.806077947278615, 110.34102008361516).obs;

  Future<void> listenLocation() async {}

  Future<void> stopListen() async {
    print("stop");
  }

  @override
  void onInit() {
    super.onInit();

    init();

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
  }

  void init() async {
    var info = await DeviceInfoPlugin().androidInfo;
    var sdkInt = info.version.sdkInt;
    print("sdkInt: ${sdkInt}");
    if (sdkInt >= 30) {
      var status = await askPermission();
      if (status.isGranted) {
        var locationResponse = await location.getLocation();

        currentLocation.value =
            LatLng(locationResponse.latitude!, locationResponse.longitude!);
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(locationResponse.latitude!, locationResponse.longitude!),
          zoom: 14.4746,
        )));

        isCurrentLocation(true);
      }
    } else {
      print(await _checkLocationPermission());
      if (await _checkLocationPermission()) {
        var locationResponse = await location.getLocation();

        currentLocation.value =
            LatLng(locationResponse.latitude!, locationResponse.longitude!);
        final GoogleMapController controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(locationResponse.latitude!, locationResponse.longitude!),
          zoom: 14.4746,
        )));

        isCurrentLocation(true);
      }
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUI(dynamic data) async {
    // final log = await FileManager.readLogFile();
    print("Log: ${data}");
    await _updateNotificationText(data);

    if (data != null) {
      lastLocation = data;
    }
    // logStr = log;
  }

  Future<void> _updateNotificationText(dynamic data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "Sedang mengirim lokasi",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    // logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();

    isRunning = _isRunning;

    print('Running ${isRunning.toString()}');
  }

  void onStopLocator() async {
    showDialog();

    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    isRunning = _isRunning;

    Store.saveIsTracking("stop");

    // Future.delayed(Duration(seconds: 3), () => Get.back());

    var locationResponse = await location.getLocation();

    var getAddress = await GeneralrProvider().requestGetAddress(
        locationResponse.latitude!, locationResponse.longitude!);

    if (getAddress.length > 0) {
      String? sessionId = await Store.getSessionId();
      Map<String, String> body = <String, String>{
        'session_id': sessionId!,
        "category": "checkout",
        "longitude": locationResponse.longitude.toString(),
        "latitude": locationResponse.latitude.toString(),
        "address": getAddress[0].formattedAddress!
      };

      ProviderException responseAddPresence =
          await ActivityProvider().requestAddPresence(body);

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
        dashboardController.fetchData("");
        Get.back();
      }

      dashboardController.fetchData("");
      Get.back();
      Future.delayed(Duration(seconds: 1), () => Get.back());
    } else {
      Get.back();
      Fluttertoast.showToast(
          msg: "Tidak ada alamat",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: kDangerColor,
          toastLength: Toast.LENGTH_LONG);
    }

    // Get.back();
  }

  void showDialog() {
    Get.dialog(
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
        useSafeArea: true);
  }

  void onStartLocator() async {
    if (await _checkLocationPermission()) {
      showDialog();
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();
      print("runnings: ${_isRunning}");

      isRunning = _isRunning;

      Store.saveIsTracking("start");

      var locationResponse = await location.getLocation();

      var getAddress = await GeneralrProvider().requestGetAddress(
          locationResponse.latitude!, locationResponse.longitude!);

      if (getAddress.length > 0) {
        String? sessionId = await Store.getSessionId();
        Map<String, String> body = <String, String>{
          'session_id': sessionId!,
          "category": "checkin",
          "longitude": locationResponse.longitude.toString(),
          "latitude": locationResponse.latitude.toString(),
          "address": getAddress[0].formattedAddress!
        };

        ProviderException responseAddPresence =
            await ActivityProvider().requestAddPresence(body);

        if (responseAddPresence.status == "failed") {
          Fluttertoast.showToast(
              msg: responseAddPresence.message,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kDangerColor,
              toastLength: Toast.LENGTH_LONG);
        } else {
          final _isRunning = await BackgroundLocator.isServiceRunning();
          print("runnings: ${_isRunning}");

          isRunning = _isRunning;
          lastLocation = null;
          Fluttertoast.showToast(
              msg: responseAddPresence.message,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: kSuccessColor,
              toastLength: Toast.LENGTH_LONG);
          dashboardController.fetchData("");
          Get.back();
          Future.delayed(Duration(seconds: 1), () => Get.back());
        }
        // dashboardController.fetchData("");

      } else {
        Get.back();
        Fluttertoast.showToast(
            msg: "Tidak ada alamat",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: kDangerColor,
            toastLength: Toast.LENGTH_LONG);
      }

      // if (_isRunning) {}
      // Future.delayed(Duration(seconds: 3), () => Get.back());
    } else {
      // show error
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

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            // accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 0),
        autoStop: false,
        androidSettings: AndroidSettings(
            // accuracy: LocationAccuracy.LOW,
            interval:
                dashboardController.mainController.cronjobLogLocationTime.value,
            // interval: 20,
            distanceFilter: 0,
            wakeLockTime: 84,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: kDangerLightColor,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onCheckIn() async {
    print("Checkin");
    // serviceEnabled = await location.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await location.requestService();
    //   if (!serviceEnabled) {
    //     return;
    //   }
    // }

    // print(locationData);
  }

  void onCheckOut() {
    print("Checkout");
  }
}
