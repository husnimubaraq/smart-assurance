import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/activity/controllers/upload_photo_controller.dart';
import 'package:tracking/components/button/button_view.dart';
import 'package:tracking/components/header/header_view.dart';

class UploadPhotoView extends GetView<UploadPhotoController> {
  var _controller = Get.put(UploadPhotoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _controller.initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(() => _controller.imagePath.value != ""
                  ? ListView(
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        HeaderView(title: "Tambah Aktifitas"),
                        Container(
                            // height: double.infinity,
                            child: InteractiveViewer(
                          minScale: 0.2,
                          maxScale: 50.2,
                          child: Image.file(File(_controller.imagePath.value),
                              height: getProportionateScreenHeight(400),
                              fit: BoxFit.contain),
                        )),
                        Container(
                          width: Get.width,
                          // height: 250,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _controller.catatan,
                                  maxLines: 6,
                                  decoration: InputDecoration(
                                      hintText: "Masukan catatan"),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonView(
                                label: "Submit",
                                onTap: _controller.onSave,
                                backgroundColor: kPrimaryColor,
                                color: kWhiteColor,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        CameraPreview(_controller.cameraController),
                      ],
                    ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() => _controller.imagePath.value != ""
          ? SizedBox()
          : FloatingActionButton(
              elevation: 0,
              onPressed: _controller.takePicture,
              child: const Icon(FeatherIcons.camera),
            )),
    );
  }
}
