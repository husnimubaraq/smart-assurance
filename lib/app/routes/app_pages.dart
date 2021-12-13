import 'package:get/get.dart';

import 'package:tracking/app/modules/activity/bindings/activity_binding.dart';
import 'package:tracking/app/modules/activity/bindings/detail_acitivity_binding.dart';
import 'package:tracking/app/modules/activity/bindings/log_activity_binding.dart';
import 'package:tracking/app/modules/activity/bindings/map_presence_binding.dart';
import 'package:tracking/app/modules/activity/bindings/upload_photo_binding.dart';
import 'package:tracking/app/modules/activity/views/activity_view.dart';
import 'package:tracking/app/modules/activity/views/detail_activity_view.dart';
import 'package:tracking/app/modules/activity/views/log_activity_view.dart';
import 'package:tracking/app/modules/activity/views/map_presence_view.dart';
import 'package:tracking/app/modules/activity/views/upload_photo_view.dart';
import 'package:tracking/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:tracking/app/modules/dashboard/bindings/dashboard_detail_teknisi_binding.dart';
import 'package:tracking/app/modules/dashboard/bindings/detail_notification_binding.dart';
import 'package:tracking/app/modules/dashboard/bindings/detail_summary_binding.dart';
import 'package:tracking/app/modules/dashboard/bindings/form_user_binding.dart';
import 'package:tracking/app/modules/dashboard/bindings/notification_binding.dart';
import 'package:tracking/app/modules/dashboard/views/dashboard_detail_teknisi_view.dart';
import 'package:tracking/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tracking/app/modules/dashboard/views/detail_notification_view.dart';
import 'package:tracking/app/modules/dashboard/views/detail_summary_view.dart';
import 'package:tracking/app/modules/dashboard/views/form_user_view.dart';
import 'package:tracking/app/modules/dashboard/views/notification_view.dart';
import 'package:tracking/app/modules/home/bindings/home_binding.dart';
import 'package:tracking/app/modules/home/views/home_view.dart';
import 'package:tracking/app/modules/login/bindings/login_binding.dart';
import 'package:tracking/app/modules/login/views/login_view.dart';
import 'package:tracking/app/modules/main/bindings/main_binding.dart';
import 'package:tracking/app/modules/main/views/main_view.dart';
import 'package:tracking/app/modules/manage/bindings/manage_binding.dart';
import 'package:tracking/app/modules/manage/bindings/manage_detail_user_binding.dart';
import 'package:tracking/app/modules/manage/bindings/manage_form_user_binding.dart';
import 'package:tracking/app/modules/manage/bindings/manage_map_user_binding.dart';
import 'package:tracking/app/modules/manage/views/manage_detail_user_view.dart';
import 'package:tracking/app/modules/manage/views/manage_form_user_view.dart';
import 'package:tracking/app/modules/manage/views/manage_map_user_view.dart';
import 'package:tracking/app/modules/manage/views/manage_view.dart';
import 'package:tracking/app/modules/profile/bindings/change_password_binding.dart';
import 'package:tracking/app/modules/profile/bindings/change_profile_binding.dart';
import 'package:tracking/app/modules/profile/bindings/profile_binding.dart';
import 'package:tracking/app/modules/profile/views/change_password_view.dart';
import 'package:tracking/app/modules/profile/views/change_profile_view.dart';
import 'package:tracking/app/modules/profile/views/profile_view.dart';
import 'package:tracking/app/modules/splash/bindings/splash_binding.dart';
import 'package:tracking/app/modules/splash/views/splash_view.dart';

// import 'package:tracking/app/modules/profile/change_password/bindings/change_password_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => DashboardView(),
        binding: DashboardBinding(),
        children: [
          GetPage(
              name: _Paths.NOTIFICATION,
              page: () => NotificationView(),
              binding: NotificationBinding(),
              children: [
                GetPage(
                  name: _Paths.DETAIL_NOTIFICATION,
                  page: () => DetailNotificationView(),
                  binding: DetailNotificationBinding(),
                ),
              ]),
          GetPage(
            name: _Paths.DETAIL_SUMMARY,
            page: () => DetailSummaryView(),
            binding: DetailSummaryBinding(),
          ),
          GetPage(
            name: _Paths.FORM_USER,
            page: () => FormUserView(),
            binding: FormUserBinding(),
          ),
          GetPage(
            name: _Paths.DASHBOARD_DETAIL_TEKNISI,
            page: () => DashboardDetailTeknisiView(),
            binding: DashboardDetailTeknisiBinding(),
          ),
        ]),
    GetPage(
        name: _Paths.MANAGE,
        page: () => ManageView(),
        binding: ManageBinding(),
        children: [
          GetPage(
            name: _Paths.MANAGE_DETAIL_USER,
            page: () => ManageDetailUserView(),
            binding: ManageDetailUserBinding(),
          ),
          GetPage(
            name: _Paths.MANAGE_MAP_USER,
            page: () => ManageMapUserView(),
            binding: ManageMapUserBinding(),
          ),
          GetPage(
            name: _Paths.MANAGE_FORM_USER,
            page: () => ManageFormUserView(),
            binding: ManageFormUserBinding(),
          ),
        ]),
    GetPage(
        name: _Paths.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding(),
        children: [
          GetPage(
            name: _Paths.CHANGE_PASSWORD,
            page: () => ChangePasswordView(),
            binding: ChangePasswordBinding(),
          ),
          GetPage(
            name: _Paths.CHANGE_PROFILE,
            page: () => ChangeProfileView(),
            binding: ChangeProfileBinding(),
          ),
        ]),
    GetPage(
        name: _Paths.ACTIVITY,
        page: () => ActivityView(),
        binding: ActivityBinding(),
        children: [
          GetPage(
            name: _Paths.MAP_PRESENCE,
            page: () => MapPresenceView(),
            binding: MapPresenceBinding(),
          ),
          GetPage(
            name: _Paths.UPLOAD_PHOTO,
            page: () => UploadPhotoView(),
            binding: UploadPhotoBinding(),
          ),
          GetPage(
            name: _Paths.LOG_ACTIVITY,
            page: () => LogActivityView(),
            binding: LogActivityBinding(),
          ),
          GetPage(
            name: _Paths.DETAIL_ACTIVITY,
            page: () => DetailActivityView(),
            binding: DetailActivityBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
