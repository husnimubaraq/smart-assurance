import 'dart:async';

import 'package:background_locator/location_dto.dart';
import 'package:get/get.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';

import 'location_service_repository.dart';

class LocationCallbackHandler extends GetxController {
  // static DashboardController dashboardController = Get.find();
  static DashboardController dashboardController =
      Get.put(DashboardController());

  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    print("callback init: ${params}");
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }

  static Future<void> disposeCallback() async {
    print("callback done: doneee");
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  static Future<void> callback(LocationDto locationDto) async {
    dashboardController.sendLocation(
        locationDto.latitude, locationDto.longitude);
    // print("callback: ${locationDto.latitude}, ${locationDto.longitude}");
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }
}
