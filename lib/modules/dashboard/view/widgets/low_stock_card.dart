import 'package:flutter/material.dart';

class LowStockCard extends StatelessWidget {
  const LowStockCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ("Mouse", 3),
      ("Keyboard", 2),
      ("HDMI Cable", 5),
      ("LAN Cable", 4),
    ];

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
              "Low Stock",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...items.map(
                  (e) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.red,
                ),
                title: Text(e.$1),
                trailing: Text(
                  "${e.$2} Left",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}