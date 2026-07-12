import 'package:flutter/material.dart';

import '../../model/dashboard_model.dart';

class ActivityList extends StatelessWidget {
  final List<ActivityItem> items;

  const ActivityList({super.key, required this.items});

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
              "Recent Activities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (items.isEmpty)
              const Text("No recent activities")
            else
              ...items.map(
                (e) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 8,
                    backgroundColor: _getColor(e.type),
                  ),
                  title: Text(e.description),
                  subtitle: Text(e.timeText),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getColor(String type) {
    switch (type.toLowerCase()) {
      case 'added': return Colors.green;
      case 'removed':
      case 'scrapped': return Colors.red;
      case 'repair': return Colors.orange;
      case 'assigned': return Colors.blue;
      default: return Colors.purple;
    }
  }
}