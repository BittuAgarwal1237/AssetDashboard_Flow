import 'package:flutter/material.dart';

class WarrantyCard extends StatelessWidget {
  const WarrantyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      ("Dell Latitude 5420", 5),
      ("HP Printer", 11),
      ("ThinkPad T14", 18),
      ("MacBook Pro", 30),
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
              "Warranty Expiring",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            ...data.map(
                  (e) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.orange,
                ),
                title: Text(e.$1),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("${e.$2} Days"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}