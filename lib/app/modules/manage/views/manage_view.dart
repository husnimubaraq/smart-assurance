import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tracking/app/helper/contants.dart';
import 'package:tracking/app/modules/main/controllers/main_controller.dart';
import 'package:tracking/app/modules/manage/views/components/manage_sm_view.dart';
import 'package:tracking/app/modules/manage/views/components/manage_team_leader_view.dart';

import '../controllers/manage_controller.dart';
import 'components/manage_roc_view.dart';

class ManageView extends GetView<ManageController> {
  var _controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSnowColor,
        body: _checkTypeUser(_controller.userPosition.value));
  }

  Widget _checkTypeUser(String type) {
    if (type == USER_ROC) {
      return ManageRocView();
    } else if (type == USER_SM) {
      return ManageSmView();
    } else {
      return ManageTeamLeaderView();
    }
  }
}
