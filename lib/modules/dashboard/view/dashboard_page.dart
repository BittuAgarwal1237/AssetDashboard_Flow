import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_controller/dashboard_controller.dart';

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
    return Scaffold(
        backgroundColor: const Color(0xffF5F7FA),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
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
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                  GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  crossAxisCount: 4,

                  crossAxisSpacing: 20,

                  mainAxisSpacing: 20,

                  childAspectRatio: 1.5,

                  children: [

                    SummaryCard(
                      title: "Total Assets",
                      value: data.totalAssets.toString(),
                      icon: Icons.laptop_mac,
                      color: Colors.blue,
                    ),

                    SummaryCard(
                      title: "Assigned",
                      value: data.assignedAssets.toString(),
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
                      title: "Repair",
                      value: data.repairAssets.toString(),
                      icon: Icons.build_circle_outlined,
                      color: Colors.red,
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Expanded(
                      flex: 2,
                      child: AssetStatusChart(),
                    ),

                    SizedBox(width: 20),

                    Expanded(
                      flex: 2,
                      child: CategoryChart(),
                    ),

                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Expanded(
                      child: QuickActions(),
                    ),

                    SizedBox(width: 20),

                    Expanded(
                      child: WarrantyCard(),
                    ),

                  ],
                ),

                const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Expanded(
                          flex: 2,
                          child: ActivityList(),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: LowStockCard(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "System Overview",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      Icons.business,
                                      color: Colors.blue,
                                    ),
                                    title: Text("Departments"),
                                    trailing: Text("08"),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      Icons.people,
                                      color: Colors.green,
                                    ),
                                    title: Text("Employees"),
                                    trailing: Text("164"),
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      Icons.devices,
                                      color: Colors.orange,
                                    ),
                                    title: Text("Active Assets"),
                                    trailing: Text("980"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
          );
        }),
    );
  }
}