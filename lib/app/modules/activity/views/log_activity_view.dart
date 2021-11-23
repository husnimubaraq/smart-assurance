import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/helper/size_config.dart';
import 'package:tracking/app/modules/activity/controllers/log_activity_controller.dart';
import 'package:tracking/app/routes/app_pages.dart';
import 'package:tracking/components/header/header_view.dart';
import 'package:tracking/components/popup/popup_view.dart';
import 'package:tracking/components/technician_item/technician_activity_item_view.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class LogActivityView extends GetView<LogActivityController> {
  var _controller = Get.put(LogActivityController());
  @override
  Widget build(BuildContext context) {
    var params = Get.arguments;
    var id_user = params != null ? params["id_user"] : null;

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kSnowColor,
      body: SafeArea(
          child: Column(
        children: [
          HeaderView(
            title: "Log Activity",
            iconRight: FeatherIcons.filter,
            onTapRight: () async {
              await Get.dialog(PopupView(
                  items: _controller.filters,
                  onTap: (int index) async {
                    print(index);
                    if (index == 0) {
                      final List<DateTime> picked =
                          await DateRangePicker.showDatePicker(
                              context: context,
                              initialDatePickerMode:
                                  DateRangePicker.DatePickerMode.day,
                              initialFirstDate: new DateTime.now(),
                              initialLastDate: new DateTime.now(),
                              firstDate: new DateTime(DateTime.now().month - 2),
                              lastDate: new DateTime.now());
                      if (picked != null && picked.length == 2) {
                        _controller.onFilterDate(
                            DateFormat("yyyy-MM-dd").format(picked[0]),
                            DateFormat("yyyy-MM-dd").format(picked[1]));
                      }
                    } else {
                      _controller.onFilter(
                          _controller.filters[index].value, index);
                    }
                  }));
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return
              //     });
            },
          ),
          Expanded(
              flex: 1,
              child: Obx(() {
                return _controller.isFirstLoadRunning.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : _controller.listActivities.length > 0
                        ? ListView.builder(
                            controller: _controller.scrollController,
                            itemCount: _controller.listActivities.length,
                            itemBuilder: (context, index) {
                              return TechnicianActivityItemView(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_ACTIVITY,
                                        arguments:
                                            _controller.listActivities[index]);
                                  },
                                  location: _controller
                                      .listActivities[index].address!,
                                  date: _controller
                                      .listActivities[index].createdDate!,
                                  status: _controller
                                          .listActivities[index].category ??
                                      null,
                                  description:
                                      _controller.listActivities[index].type ==
                                              "AKTIFITAS"
                                          ? _controller
                                              .listActivities[index].catatan!
                                          : _controller.listActivities[index]
                                              .createdDate!,
                                  activity:
                                      _controller.listActivities[index].type!);
                            })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Tidak ada data",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          );
              })),
          Obx(() {
            return _controller.isLoadMoreRunning.value == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox();
          })
        ],
      )),
      // floatingActionButton: id_user != null
      //     ? FloatingActionButton(
      //         elevation: 0,
      //         onPressed: _controller.sendRequestActivity,
      //         child: const Icon(Icons.notifications_active),
      //         backgroundColor: kWarningColor,
      //       )
      //     : null,
    );
  }
}
