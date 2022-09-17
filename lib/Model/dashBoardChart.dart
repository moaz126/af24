import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../api/auth_af24.dart';

class dashBoardChart extends StatefulWidget {
  const dashBoardChart({Key? key}) : super(key: key);

  @override
  State<dashBoardChart> createState() => _dashBoardChartState();
}

class _dashBoardChartState extends State<dashBoardChart> {
  bool loader = false;
  fun() async {
    setState(() {
      loader = true;
    });
    await DataApiService.instance.getDashboard();
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fun();
    super.initState();
    setState(() {});
  }

  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );
  final buttonspinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );
  List<String> x_axis = getDashboardContent!.xAxis;
  List<int> y_axis = getDashboardContent!.yAxis;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loader == true
            ? spinkit
            : Center(
                child: Container(
                    height: 50.h,
                    child: SfCartesianChart(
                        // Initialize category axis
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<SalesData, String>>[
                          LineSeries<SalesData, String>(
                              // Bind data source
                              dataSource: <SalesData>[
                                for (int i = 0; i < x_axis.length; i++)
                                  SalesData(x_axis[i].toString(),
                                      y_axis[i].toDouble()),
                              ],
                              xValueMapper: (SalesData sales, _) => sales.year,
                              yValueMapper: (SalesData sales, _) => sales.sales)
                        ]))));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
