import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class dashBoardChart extends StatefulWidget {
  const dashBoardChart({Key? key}) : super(key: key);
  @override
  _dashBoardChartState createState() => _dashBoardChartState();
}

class _dashBoardChartState extends State<dashBoardChart> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime.now().add(Duration(days: 130, hours: 5),),0),
      SalesData(DateTime.now().add(Duration(days: -130, hours: 21),),50),
      SalesData(DateTime.now().add(Duration(days: -150, hours: 23),),30),
      SalesData(DateTime.now().add(Duration(days: -180, hours: 5),),60),
      SalesData(DateTime.now().add(Duration(days: -175, hours: 15),),90),
    ];
    return Scaffold(
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <ChartSeries>[
                      // Renders line chart
                      LineSeries<SalesData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales
                      )
                    ]
                )
            )
        )
    );
  }
}


class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
