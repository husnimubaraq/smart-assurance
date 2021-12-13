import 'package:get/get.dart';
import 'package:tracking/app/data/models/user_admin_response_model.dart';
import 'package:tracking/app/data/models/user_model.dart';
import 'package:tracking/app/data/models/user_roc_leader_response_model.dart'
    as UserRocLeader;
import 'package:tracking/app/data/models/user_teknisi_response_model.dart'
    as UserTerknisi;
import 'package:tracking/app/data/models/user_admin_response_model.dart'
    as UserAdmin;
import 'package:tracking/app/helper/store.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var userPosition = "".obs;

  var serviceLocation = false.obs;

  // final MapPresenceController mapPresenceController = Get.find();

  final user = User().obs;
  final dashboardRocLeader = UserRocLeader.Dashboard().obs;
  final dashboardTeknisi = UserTerknisi.Dashboard().obs;
  final dashboardAdmin = UserAdmin.Dashboard().obs;

  final idleUsers = UserRocLeader.Dashboard().idleUsers.obs;
  final lastPresences = UserTerknisi.LastActivities().lists.obs;
  final lastLocations = UserTerknisi.LastActivities().lists.obs;

  final notifActiveRoc = 0.obs;
  final notifActiveTeknisi = 0.obs;

  var users = UserAdmin.Dashboard().users.obs;

  var baseUrl = "".obs;
  var cronjobLogLocationTime = 10.obs;

  @override
  void onInit() {
    super.onInit();
    print('onInit');
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
