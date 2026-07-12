import 'package:get/get.dart';

import '../model/dashboard_model.dart';

class DashboardController extends GetxController {
  // Loading State
  final RxBool isLoading = false.obs;

  // Dashboard Data
  final Rx<DashboardModel> dashboard = DashboardModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;

      // Simulate API Delay
      await Future.delayed(const Duration(milliseconds: 600));

      dashboard.value = const DashboardModel(
        totalAssets: 1240,
        assignedAssets: 980,
        availableAssets: 210,
        repairAssets: 25,
        scrapAssets: 18,
        lostAssets: 7,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}