import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/providers/activity_provider.dart';
import 'package:tracking/app/data/providers/general_provider.dart';
import 'package:tracking/app/data/providers/provider.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/store.dart';
import 'package:tracking/app/modules/activity/controllers/activity_controller.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';

class UploadPhotoController extends GetxController {
  //TODO: Implement UploadPhotoController

  var activiyC = Get.put(ActivityController());
  var dashboardC = Get.put(DashboardController());

  late CameraController cameraController;
  late Future<void> initializeCameraControllerFuture;
  late TextEditingController catatan;
  // late CameraDescription cameraDescription;

  final count = 0.obs;

  var imagePath = "".obs;

  Location location = new Location();
  late LocationData locationData;
  String address = "";

  @override
  void onInit() {
    super.onInit();

    catatan = TextEditingController();

    cameraController =
        CameraController(activiyC.cameraDescription, ResolutionPreset.veryHigh);

    initializeCameraControllerFuture = cameraController.initialize();
    init();
    // availableCameras().then((cameras) {
    //   final camera = cameras
    //       .where((camera) => camera.lensDirection == CameraLensDirection.back)
    //       .toList()
    //       .first;
    //   cameraDescription = camera;

    //   cameraController = CameraController(camera, ResolutionPreset.medium);
    // });

    // initializeCameraControllerFuture = cameraController.initialize();
  }

  void init() async {
    locationData = await location.getLocation();

    var getAddress = await GeneralrProvider()
        .requestGetAddress(locationData.latitude!, locationData.longitude!);
    address = getAddress[0].formattedAddress!;
  }

  void takePicture() async {
    try {
      await initializeCameraControllerFuture;

      final image = await cameraController.takePicture();

      imagePath.value = image.path;
    } catch (e) {
      print(e);
    }
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

  void onSave() async {
    showDialog();

    String? sessionId = await Store.getSessionId();
    Map<String, String> body = <String, String>{
      'session_id': sessionId!,
      "category": "checkout",
      "longitude": locationData.longitude.toString(),
      "latitude": locationData.latitude.toString(),
      "address": address,
      "catatan": catatan.text
    };

    ProviderException responseAddPresence = await ActivityProvider()
        .requestAddActivity(body,
            path: imagePath.value, pathBody: "image_file");

    if (responseAddPresence.status == "failed") {
      Get.back();
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
      dashboardC.fetchData("");
      Get.back();
      Future.delayed(Duration(seconds: 1), () => Get.back());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  @override
  void dispose() {
    cameraController.dispose();
    imagePath.value = "";
    super.dispose();
  }
}
