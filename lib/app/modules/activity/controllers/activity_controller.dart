import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:camera/camera.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracking/app/data/models/technician_activity_model.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:permission_handler/permission_handler.dart'
    as permision_handler;
import 'package:location_permissions/location_permissions.dart'
    as location_permissions;
import 'package:tracking/app/helper/location_callback_handler.dart';
import 'package:tracking/app/helper/location_service_repository.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/components/technician_item/technician_activity_item_view.dart';
// import 'package:background_location/background_location.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityController extends GetxController {
  //TODO: Implement ActivityController
  var dashboardController = Get.put(DashboardController());
  var mainController = Get.put(MainController());

  ReceivePort port = ReceivePort();

  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';

  late CameraDescription cameraDescription;

  List<TechnicianActivity> activities = [
    new TechnicianActivity(
        activity: "activity",
        status: null,
        date: "26 September 2021",
        time: "09:35",
        location: "Jl Bibis Perum UMY"),
    new TechnicianActivity(
        activity: "location",
        status: null,
        date: "26 September 2021",
        time: "09:00",
        location: "Jl Bibis Perum UMY"),
    new TechnicianActivity(
        activity: "presensi",
        status: TechnicianActivityItemView.CHECKIN,
        date: "26 September 2021",
        time: "08:00",
        location: "Jl Bibis Perum UMY"),
    new TechnicianActivity(
        activity: "presensi",
        status: TechnicianActivityItemView.CHECKOUT,
        date: "25 September 2021",
        time: "17:00",
        location: "Jl Sonopakis, UPY"),
    new TechnicianActivity(
        activity: "location",
        status: null,
        date: "25 September 2021",
        time: "16:00",
        location: "Jl Sonopakis, UPY"),
  ];

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    final cameras = await availableCameras();

    cameraDescription = cameras.first;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print("init activity");

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
        print("data: ${data}");
        // await updateUI(data);
      },
    );
    initPlatformState();
    initCamera();
  }

  void init() async {
    var info = await DeviceInfoPlugin().androidInfo;
    var sdkInt = info.version.sdkInt;
    print("sdkInt: ${sdkInt}");
    if (sdkInt >= 30) {
      var status = await askPermission();
      if (status.isGranted) {
        print('true');
      }
    } else {
      print(await _checkLocationPermission());
      if (await _checkLocationPermission()) {
        print('true');
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

  Future<void> initPlatformState() async {
    // logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();

    print('Running ${_isRunning.toString()}');

    if (_isRunning == false) {
      var tracking = await Store.getIsTracking();
      if (tracking == "start") {
        await _startLocator();
      }
    }
  }

  void onCheckIn() async {
    final Permission location_permission = Permission.location;
    bool location_status = false;
    bool ispermanetelydenied = await location_permission.isPermanentlyDenied;
    if (ispermanetelydenied) {
      print("denied");
      await openAppSettings();
    } else {
      var location_statu = await location_permission.request();
      location_status = location_statu.isGranted;
      print(location_status);
    }
  }

  void onCheckOut() async {
    // BackgroundLocation.stopLocationService();
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
            // interval: 20,
            interval: mainController.cronjobLogLocationTime.value,
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
  void increment() => count.value++;
}
