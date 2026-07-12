import 'package:get/get.dart';

import '../model/dashboard_model.dart';
import '../service/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();
  DashboardService get service => _service;

  final RxBool isLoading = false.obs;

  final Rx<DashboardModel> dashboard =
      DashboardModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;
      dashboard.value = await _service.fetchDashboard();
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