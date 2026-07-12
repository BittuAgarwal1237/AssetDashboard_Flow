import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetStatusChart extends StatelessWidget {
  const AssetStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ChartData> data = [
      _ChartData('Assigned', 980, Colors.blue),
      _ChartData('Available', 210, Colors.green),
      _ChartData('Repair', 25, Colors.orange),
      _ChartData('Scrap', 18, Colors.grey),
      _ChartData('Lost', 7, Colors.red),
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
              "Asset Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 280,
              child: SfCircularChart(
                legend: const Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  DoughnutSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.title,
                    yValueMapper: (_ChartData data, _) => data.value,
                    pointColorMapper: (_ChartData data, _) => data.color,
                    innerRadius: '70%',
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
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

class _ChartData {
  final String title;
  final double value;
  final Color color;

  _ChartData(
      this.title,
      this.value,
      this.color,
      );
}