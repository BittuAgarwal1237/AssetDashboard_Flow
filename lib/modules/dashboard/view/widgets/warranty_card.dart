import 'package:flutter/material.dart';

import '../../model/dashboard_model.dart';

class WarrantyCard extends StatelessWidget {
  final List<WarrantyItem> items;

  const WarrantyCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Warranty Expiring",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            if (items.isEmpty)
              const Text("No warranties expiring soon")
            else
              ...items.map(
                    (e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.verified_user_outlined,
                    color: Colors.orange,
                  ),
                  title: Text(e.name),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("${e.daysLeft} Days"),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}