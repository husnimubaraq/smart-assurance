import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tracking/app/modules/dashboard/views/components/sub_tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/tab_item_view.dart';
import 'package:tracking/app/modules/dashboard/views/components/user_item_view.dart';
import 'package:tracking/app/modules/manage/controllers/manage_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/button/button_item_view.dart';
import 'package:tracking/components/input/input_default_view.dart';
import 'package:tracking/components/section_list/section_list_view.dart';
import 'package:tracking/components/technician_item/technician_location_item_view.dart';
import 'package:tracking/components/technician_item/technician_presence_item_view.dart';

class ManageTeamLeaderView extends GetView<ManageController> {
  var _controller = Get.put(ManageController());

  ManageTeamLeaderView();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // return SafeArea(
    //     child: Column(
    //   children: [
    //     Expanded(
    //       flex: 1,
    //       child: RefreshIndicator(
    //         onRefresh: _controller.onRefresh,
    //         child: ListView(
    //           children: [
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Container(
    //               margin: EdgeInsets.symmetric(horizontal: 15),
    //               width: double.infinity,
    // decoration: BoxDecoration(
    //   color: Colors.white,
    //   borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(10),
    //       topRight: Radius.circular(10),
    //       bottomLeft: Radius.circular(10),
    //       bottomRight: Radius.circular(10)),
    //   boxShadow: [
    //     BoxShadow(
    //       color: Colors.grey.withOpacity(0.1),
    //       spreadRadius: 1,
    //       blurRadius: 7,
    //       offset: Offset(0, 1), // changes position of shadow
    //     ),
    //   ],
    // ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 30,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             padding: EdgeInsets.symmetric(
    //                 vertical: 15, horizontal: 15),
    //             width: getProportionateScreenWidth(120),
    //             height: 100,
    //             decoration: BoxDecoration(
    //                 color: kDangerColor,
    //                 borderRadius: BorderRadius.circular(10)),
    //             child: Obx(() {
    //               return Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     _controller.teknisiUsers.length.toString(),
    //                     style: TextStyle(
    //                         fontFamily: "Poppins",
    //                         fontSize: 18,
    //                         color: kWhiteColor,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                   Text(
    //                     "Teknisi",
    //                     style: TextStyle(
    //                         fontFamily: "Poppins",
    //                         fontSize: 12,
    //                         color: kWhiteColor,
    //                         fontWeight: FontWeight.w500),
    //                   ),
    //                 ],
    //               );
    //             }),
    //           )
    //         ],
    //       ),
    //       SizedBox(
    //         height: 30,
    //       ),
    //     ],
    //   ),
    // ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             Obx(() {
    //               return SectionListView(
    //                   label: "Teknisi",
    //                   itemLength: _controller.teknisiUsers.length,
    //                   // onTapMore: () {
    //                   //   // Get.toNamed(Routes.MANAGE_ALL_USER,
    //                   //   //     arguments: ["Teknisi", controller.teknisiUsers]);
    //                   // },
    //                   child: Column(
    //                     children: List.generate(_controller.teknisiUsers.length,
    //                         (index) {
    //                       return UserItemView(
    //                           onTap: () {
    //                             Get.toNamed(Routes.DASHBOARD_DETAIL_TEKNISI,
    //                                 arguments: _controller.teknisiUsers[index]);
    //                           },
    //                           name: _controller.teknisiUsers[index].name!,
    //                           position:
    //                               _controller.teknisiUsers[index].userType!,
    //                           avatar: "assets/images/avatar2.png");
    //                     }),
    //                   ));
    //             }),
    //             SizedBox(
    //               height: 15,
    //             ),
    // ButtonItemView(
    //   label: "Tambah User",
    //   description:
    //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    //   onTap: () {
    //     Get.toNamed(Routes.MANAGE_FORM_USER);
    //   },
    // ),
    // SizedBox(
    //   height: 20,
    // ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // ));

    return SafeArea(
        child: Stack(
      children: [
        Obx(
          () => GoogleMap(
            markers: Set<Marker>.of(_controller.markers.values),
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _controller.currentLocation.value,
              zoom: 11.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.mapController.complete(controller);
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: 170,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: getProportionateScreenWidth(120),
                    height: 100,
                    decoration: BoxDecoration(
                        color: kDangerColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Obx(() {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _controller.teknisiUsers.length.toString(),
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Teknisi",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                color: kWhiteColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 1,
            // maxChildSize: 0.75,
            builder: (BuildContext context, ScrollController scrollController) {
              return Obx(() {
                return Container(
                  // margin:
                  //     EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Teknisi",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView(
                          controller: scrollController,
                          children: [
                            Container(
                              child: Column(
                                children: List.generate(
                                    _controller.teknisiUsers.length,
                                    (index) => UserItemView(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.DASHBOARD_DETAIL_TEKNISI,
                                              arguments: _controller
                                                  .teknisiUsers[index]);
                                        },
                                        name: _controller
                                            .teknisiUsers[index].name!,
                                        position: _controller
                                            .teknisiUsers[index].nik!,
                                        avatar: "assets/images/avatar2.png")),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonItemView(
                              label: "Tambah User",
                              description:
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                              onTap: () {
                                Get.toNamed(Routes.MANAGE_FORM_USER);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        // child: ListView.builder(
                        //     controller: scrollController,
                        //     itemCount: _controller.teknisiUsers.length > 0 ? _controller.teknisiUsers.length + 1 : 1,

                        //     itemBuilder: (context, index) {
                        //       return UserItemView(
                        //           onTap: () {
                        //             Get.toNamed(Routes.DASHBOARD_DETAIL_TEKNISI,
                        //                 arguments:
                        //                     _controller.teknisiUsers[index]);
                        //           },
                        //           name: _controller.teknisiUsers[index].name!,
                        //           position:
                        //               _controller.teknisiUsers[index].nik!,
                        //           avatar: "assets/images/avatar2.png");
                        //     }),
                      ),
                      // ButtonItemView(
                      //   label: "Tambah User",
                      //   description:
                      //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                      //   onTap: () {
                      //     Get.toNamed(Routes.MANAGE_FORM_USER);
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                );
              });
            }),
      ],
    ));
  }
}
