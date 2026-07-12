import 'package:get/get.dart';

import '../model/dashboard_model.dart';
import '../service/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();
  DashboardService get service => _service;

  final RxBool isLoading = false.obs;

  final Rx<DashboardModel> dashboard =
      DashboardModel.empty().obs;

  final RxList<Map<String, dynamic>> statusChart =
      <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> categoryChart =
      <Map<String, dynamic>>[].obs;

  final RxList<Map<String, dynamic>> recentActivities =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      dashboard.value =
      await _service.getDashboard();

      statusChart.assignAll(
        await _service.getStatusChart(),
      );

      categoryChart.assignAll(
        await _service.getCategoryChart(),
      );

      recentActivities.assignAll(
        await _service.getRecentActivities(),
      );
    } catch (e) {
      Get.snackbar(
        "Dashboard Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}