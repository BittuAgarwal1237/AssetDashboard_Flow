import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryChart extends StatelessWidget {
  const CategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_CategoryData> data = [

      _CategoryData("Laptop", 420),

      _CategoryData("Desktop", 210),

      _CategoryData("Monitor", 180),

      _CategoryData("Printer", 70),

      _CategoryData("Router", 40),

      _CategoryData("Others", 25),
    ];

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

                  ColumnSeries<_CategoryData, String>(

                    dataSource: data,

                    xValueMapper: (_CategoryData data, _) => data.category,

                    yValueMapper: (_CategoryData data, _) => data.total,

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

class _CategoryData {

  final String category;

  final double total;

  _CategoryData(
      this.category,
      this.total,
      );

}