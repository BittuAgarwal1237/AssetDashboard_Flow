import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/responsive.dart';
import '../view_controller/dashboard_controller.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/activity_list.dart';
import 'widgets/asset_status_chart.dart';
import 'widgets/category_chart.dart';
import 'widgets/low_stock_card.dart';
import 'widgets/quick_actions.dart';
import 'widgets/summary_card.dart';
import 'widgets/warranty_card.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.adaptiveSpacing;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22 * context.fontScale,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.refreshDashboard,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = controller.dashboard.value;

        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: context.adaptiveHPadding,
            child: Column(
              children: [
                const DashboardHeader(),

                SizedBox(height: spacing),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: context.gridColumns,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: context.useCompactMode ? 1.1 : 1.5,
                  children: [
                    SummaryCard(
                      title: "Total Assets",
                      value: data.totalAssets.toString(),
                      icon: Icons.laptop_mac,
                      color: Colors.blue,
                    ),
                    SummaryCard(
                      title: "Allocated",
                      value: data.allocatedAssets.toString(),
                      icon: Icons.person_outline,
                      color: Colors.green,
                    ),
                    SummaryCard(
                      title: "Available",
                      value: data.availableAssets.toString(),
                      icon: Icons.inventory_2_outlined,
                      color: Colors.orange,
                    ),
                    SummaryCard(
                      title: "Maintenance",
                      value: data.maintenanceAssets.toString(),
                      icon: Icons.build_circle_outlined,
                      color: Colors.red,
                    ),
                  ],
                ),

                SizedBox(height: spacing),

                context.isMobileScreen
                    ? Column(
                  children: [
                    AssetStatusChart(data: data.assetStatusList),
                    SizedBox(height: spacing),
                    CategoryChart(data: data.categoryDataList),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AssetStatusChart(data: data.assetStatusList),
                    ),
                    SizedBox(width: spacing),
                    Expanded(
                      flex: 2,
                      child: CategoryChart(data: data.categoryDataList),
                    ),
                  ],
                ),

                SizedBox(height: spacing),

                context.isMobileScreen
                    ? Column(
                  children: [
                    const QuickActions(),
                    SizedBox(height: spacing),
                    WarrantyCard(items: data.warrantyItems),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: QuickActions()),
                    SizedBox(width: spacing),
                    Expanded(child: WarrantyCard(items: data.warrantyItems)),
                  ],
                ),

                SizedBox(height: spacing),

                context.isMobileScreen
                    ? Column(
                  children: [
                    ActivityList(items: data.recentActivities),
                    SizedBox(height: spacing),
                    LowStockCard(items: data.lowStockItems),
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ActivityList(items: data.recentActivities),
                    ),
                    SizedBox(width: spacing),
                    Expanded(child: LowStockCard(items: data.lowStockItems)),
                  ],
                ),

                SizedBox(height: spacing),

                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(context.adaptivePadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "System Overview",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.business,
                                  color: Colors.blue,
                                ),
                                title: const Text("Departments"),
                                trailing: Text(data.departments.toString().padLeft(2, '0')),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.people,
                                  color: Colors.green,
                                ),
                                title: const Text("Employees"),
                                trailing: Text(data.employees.toString()),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(
                                  Icons.devices,
                                  color: Colors.orange,
                                ),
                                title: const Text("Active Assets"),
                                trailing: Text(data.totalAssets.toString()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: spacing * 1.5),
              ],
            ),
          ),
        );
      }),
    );
  }
}