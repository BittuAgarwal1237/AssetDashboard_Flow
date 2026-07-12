import 'package:flutter/material.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      ("Laptop assigned to Rahul", "2 min ago", Colors.blue),
      ("Printer sent to repair", "10 min ago", Colors.orange),
      ("Mouse returned", "25 min ago", Colors.green),
      ("Monitor added", "1 hour ago", Colors.purple),
      ("Laptop scrapped", "Yesterday", Colors.red),
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
              "Recent Activities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...activities.map(
                  (e) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 8,
                  backgroundColor: e.$3,
                ),
                title: Text(e.$1),
                subtitle: Text(e.$2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}