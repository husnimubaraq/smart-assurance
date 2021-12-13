import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/dashboard/views/components/user_item_view.dart';
import 'package:tracking/app/modules/manage/controllers/manage_detail_user_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/header/header_view.dart';

class ManageDetailUserView extends GetView<ManageDetailUserController> {
  var _controller = Get.put(ManageDetailUserController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    User? user = Get.arguments;
    return Scaffold(
      backgroundColor: kSnowColor,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0,
      //   onPressed: () {
      //     Get.toNamed(Routes.MANAGE_MAP_USER,
      //         arguments: _controller.teknisiUsers.value);
      //   },
      //   child: const Icon(FeatherIcons.map),
      //   backgroundColor: kPrimaryColor,
      // ),
      // body: SafeArea(
      //     child: Column(
      //   children: [
      //     HeaderView(title: "Detail Team Leader"),
      //     Expanded(
      //       flex: 1,
      //       child: RefreshIndicator(
      //         onRefresh: _controller.onRefresh,
      //         child: ListView(
      //           children: [
      //             SizedBox(
      //               height: 20,
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 // Get.toNamed(Routes.CHANGE_PROFILE);
      //               },
      //               child: Padding(
      //                   padding: EdgeInsets.only(left: 15),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           CircleAvatar(
      //                             backgroundImage:
      //                                 AssetImage('assets/images/avatar.jpeg'),
      //                           ),
      //                           Container(
      //                             margin: EdgeInsets.only(left: 10),
      //                             child: Column(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Text(
      //                                   user != null ? user.name! : "",
      //                                   style: TextStyle(
      //                                     fontFamily: "Poppins",
      //                                     fontSize: 16,
      //                                   ),
      //                                 ),
      //                                 Text(
      //                                   user != null ? user.userType! : "",
      //                                   style: TextStyle(
      //                                       fontFamily: "Poppins",
      //                                       fontSize: 12,
      //                                       height: 1,
      //                                       fontWeight: FontWeight.normal),
      //                                 ),
      //                               ],
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                       // Padding(
      //                       //   padding: EdgeInsets.only(right: 10),
      //                       //   child: Icon(
      //                       //     Icons.edit,
      //                       //     color: Colors.grey,
      //                       //     size: 18,
      //                       //   ),
      //                       // )
      //                     ],
      //                   )),
      //             ),
      //             SizedBox(height: 20),
      //             Container(
      //               margin: EdgeInsets.symmetric(horizontal: 15),
      //               width: double.infinity,
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.only(
      //                     topLeft: Radius.circular(10),
      //                     topRight: Radius.circular(10),
      //                     bottomLeft: Radius.circular(10),
      //                     bottomRight: Radius.circular(10)),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.1),
      //                     spreadRadius: 1,
      //                     blurRadius: 7,
      //                     offset: Offset(0, 1), // changes position of shadow
      //                   ),
      //                 ],
      //               ),
      //               child: Column(
      //                 children: [
      //                   SizedBox(
      //                     height: 5,
      //                   ),
      //                   Padding(
      //                     padding:
      //                         EdgeInsets.only(left: 10, right: 10, top: 10),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Container(
      //                               margin: EdgeInsets.only(right: 10),
      //                               child: Icon(Icons.email_outlined,
      //                                   color: Colors.grey, size: 18),
      //                             ),
      //                             Text(
      //                               "Email:",
      //                               style: TextStyle(
      //                                   fontFamily: "Poppins",
      //                                   fontSize: 12,
      //                                   color: Colors.grey),
      //                             ),
      //                           ],
      //                         ),
      //                         Text(
      //                           user != null ? user.email! : "",
      //                           style: TextStyle(
      //                             fontFamily: "Poppins",
      //                             fontSize: 12,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding:
      //                         EdgeInsets.only(left: 10, right: 10, top: 10),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Container(
      //                               margin: EdgeInsets.only(right: 10),
      //                               child: Icon(
      //                                 Icons.phone,
      //                                 color: Colors.grey,
      //                                 size: 18,
      //                               ),
      //                             ),
      //                             Text(
      //                               "Phone:",
      //                               style: TextStyle(
      //                                   fontFamily: "Poppins",
      //                                   fontSize: 12,
      //                                   color: Colors.grey),
      //                             ),
      //                           ],
      //                         ),
      //                         Text(
      //                           "08123456789",
      //                           style: TextStyle(
      //                             fontFamily: "Poppins",
      //                             fontSize: 12,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding:
      //                         EdgeInsets.only(left: 10, right: 10, top: 10),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Row(
      //                           children: [
      //                             Container(
      //                               margin: EdgeInsets.only(right: 10),
      //                               child: Icon(Icons.card_membership,
      //                                   color: Colors.grey, size: 18),
      //                             ),
      //                             Text(
      //                               "NIK:",
      //                               style: TextStyle(
      //                                   fontFamily: "Poppins",
      //                                   fontSize: 12,
      //                                   color: Colors.grey),
      //                             ),
      //                           ],
      //                         ),
      //                         Text(
      //                           user != null ? user.nik! : "",
      //                           style: TextStyle(
      //                             fontFamily: "Poppins",
      //                             fontSize: 12,
      //                           ),
      //                           textAlign: TextAlign.right,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 15,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Container(
      //               width: double.infinity,
      //               height: 300,
      //               child: Obx(
      //                 () => GoogleMap(
      //                   markers: Set<Marker>.of(_controller.markers.values),
      //                   mapType: MapType.normal,
      //                   zoomControlsEnabled: false,
      //                   initialCameraPosition: CameraPosition(
      //                     target: _controller.currentLocation.value,
      //                     zoom: 14.4746,
      //                   ),
      //                   onMapCreated: (GoogleMapController controller) {
      //                     _controller.mapController.complete(controller);
      //                   },
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(left: 15),
      //               child: Text("Teknisi",
      //                   style: TextStyle(
      //                     fontFamily: "Poppins",
      //                     fontSize: 14,
      //                     color: Colors.black54,
      //                     fontWeight: FontWeight.w500,
      //                   )),
      //             ),
      //             Obx(() {
      //               return Column(
      //                 children: List.generate(
      //                     _controller.teknisiUsers.length,
      //                     (index) => UserItemView(
      //                         onTap: () {
      //                           Get.toNamed(Routes.DASHBOARD_DETAIL_TEKNISI,
      //                               arguments: _controller.teknisiUsers[index]);
      //                         },
      //                         name: _controller.teknisiUsers[index].name!,
      //                         position: _controller.teknisiUsers[index].nik!,
      //                         avatar: "assets/images/avatar2.png")),
      //               );
      //             }),
      //             SizedBox(
      //               height: 20,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // )),
      body: SafeArea(
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
              height: 200,
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
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/avatar.jpeg'),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user != null ? user.name! : "",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          user != null ? user.userType! : "",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              height: 1,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.email_outlined,
                                      color: Colors.grey, size: 18),
                                ),
                                Text(
                                  "Email:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              user != null ? user.email! : "",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                ),
                                Text(
                                  "Phone:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              "08123456789",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.card_membership,
                                      color: Colors.grey, size: 18),
                                ),
                                Text(
                                  "NIK:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              user != null ? user.nik! : "",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(FeatherIcons.user,
                                      color: Colors.grey, size: 18),
                                ),
                                Text(
                                  "Upline:",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              user != null ? user.uplineUserName! : "",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.3,
                maxChildSize: 1,
                // maxChildSize: 0.75,
                builder:
                    (BuildContext context, ScrollController scrollController) {
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
                            child: _controller.teknisiUsers.length > 0
                                ? ListView.builder(
                                    controller: scrollController,
                                    itemCount: _controller.teknisiUsers.length,
                                    itemBuilder: (context, index) {
                                      return UserItemView(
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
                                          avatar: "assets/images/avatar2.png");
                                    })
                                : Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text("Tidak ada data",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                          ),
                        ],
                      ),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }
}
