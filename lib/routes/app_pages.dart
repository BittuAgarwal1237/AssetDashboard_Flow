import 'package:get/get.dart';

import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/view/dashboard_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [

    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),

  ];
}