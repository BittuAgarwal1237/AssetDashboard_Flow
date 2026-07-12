import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/dashboard_model.dart';

class AssetStatusChart extends StatelessWidget {
  final List<AssetStatusData> data;

  const AssetStatusChart({super.key, required this.data});

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
                  DoughnutSeries<AssetStatusData, String>(
                    dataSource: data,
                    xValueMapper: (AssetStatusData d, _) => d.title,
                    yValueMapper: (AssetStatusData d, _) => d.value,
                    pointColorMapper: (AssetStatusData d, _) {
                      switch (d.title.toLowerCase()) {
                        case 'assigned': return Colors.blue;
                        case 'available': return Colors.green;
                        case 'repair': return Colors.orange;
                        case 'scrap': return Colors.grey;
                        case 'lost': return Colors.red;
                        default: return Colors.blueGrey;
                      }
                    },
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