import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_controller/dashboard_controller.dart';
import 'quick_action_forms.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final service = controller.service;
    final refresh = controller.refreshDashboard;

    return Card(

      elevation: 0,

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(16),

        side: BorderSide(
          color: Colors.grey.shade200,
        ),

      ),

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(

              "Quick Actions",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 20),

            GridView.count(

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              crossAxisCount: 3,

              crossAxisSpacing: 12,

              mainAxisSpacing: 12,

              children: [

                _ActionButton(
                  icon: Icons.add_box_outlined,
                  title: "Add",
                  onTap: () => Get.bottomSheet(AddAssetForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),

                _ActionButton(
                  icon: Icons.person_add_alt,
                  title: "Assign",
                  onTap: () => Get.bottomSheet(AssignAssetForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),

                _ActionButton(
                  icon: Icons.keyboard_return,
                  title: "Return",
                  onTap: () => Get.bottomSheet(ReturnAssetForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),

                _ActionButton(
                  icon: Icons.build,
                  title: "Repair",
                  onTap: () => Get.bottomSheet(RepairAssetForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),

                _ActionButton(
                  icon: Icons.delete_outline,
                  title: "Delete",
                  onTap: () => Get.bottomSheet(DeleteAssetForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),

                _ActionButton(
                  icon: Icons.people_alt_outlined,
                  title: "Employees",
                  onTap: () => Get.bottomSheet(AddEmployeeForm(service: service, onSuccess: refresh), isScrollControlled: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {

  final IconData icon;

  final String title;

  final VoidCallback onTap;

  const _ActionButton({

    required this.icon,

    required this.title,

    required this.onTap,

  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      borderRadius: BorderRadius.circular(12),

      onTap: onTap,

      child: Container(

        decoration: BoxDecoration(

          color: Colors.grey.shade100,

          borderRadius: BorderRadius.circular(12),

        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(

              icon,

              color: Colors.blue,

            ),

            const SizedBox(height: 10),

            Text(title),

          ],

        ),

      ),

    );

  }

}