import 'package:get/get.dart';

import '../model/dashboard_model.dart';
import '../service/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _service = DashboardService();

  final isLoading = false.obs;
  final dashboard = DashboardModel.empty().obs;

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
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}