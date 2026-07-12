import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/dashboard_model.dart';

class CategoryChart extends StatelessWidget {
  final List<CategoryData> data;

  const CategoryChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
              "Asset Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 280,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                ),
                series: <CartesianSeries>[
                  ColumnSeries<CategoryData, String>(
                    dataSource: data,
                    xValueMapper: (CategoryData d, _) => d.category,
                    yValueMapper: (CategoryData d, _) => d.total,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}