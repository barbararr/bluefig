import 'dart:html';

import 'package:adaptive_design/ui/common/models/module_model.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_main_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_modules_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_patient_appbar.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_patient_last_records.dart';
import 'package:adaptive_design/ui/screens/home/widgets/doctor/desktop_patients_list_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/log_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/models/category_model.dart';
import '../../../../common/models/user_model.dart';
import '../api_data_provider.dart';
import 'desktop_notification_page_patient.dart';
import 'desktop_replies_page.dart';
//import 'package:interactive_chart/interactive_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:fl_animated_linechart/fl_animated_linechart.dart';
//import 'package:fl_animated_linechart/chart/area_line_chart.dart';
//import 'package:fl_animated_linechart/common/pair.dart';
//import 'package:charts_flutter/flutter.dart' as charts;

import '../../../../common/globals.dart' as globals;

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}

class DesktopStatisticsPatientPagePatient extends StatefulWidget {
  const DesktopStatisticsPatientPagePatient({Key? key}) : super(key: key);

  @override
  State<DesktopStatisticsPatientPagePatient> createState() =>
      _DesktopStatisticsPatientPagePatientState();
}

class _DesktopStatisticsPatientPagePatientState
    extends State<DesktopStatisticsPatientPagePatient> {
  List<String> categories = [
    'Данные',
    'Статистика',
    'Последние записи',
    'Добавить запись'
  ];

  Map<String, String> patientData = {};

  List<String> elementsEnterDoctor = ['Email', 'Password', 'Name'];
  String selectedCategory = '';
  List<String> listOfElements = [];

  Map<String, String>? getPatientData() {
    return globals.user?.getData();
  }

  List<TextSpan> createListText() {
    patientData = getPatientData()!;
    List<TextSpan> list = [];
    for (var v in patientData.keys) {
      list.add(TextSpan(
          text: v + ':', style: const TextStyle(fontWeight: FontWeight.bold)));
      list.add(const TextSpan(text: " "));
      list.add(TextSpan(text: patientData[v]));
      list.add(const TextSpan(text: "\n\n"));
    }
    return list;
  }

  TextSpan patientDataToString() {
    var text = TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: createListText());
    print(text);
    return text;
  }

  List<Widget> getChoiceChips() {
    return categories
        .map(
          (category) => ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedCategory = category;
                  } else {
                    selectedCategory = '';
                  }
                  if (selectedCategory == 'Данные') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopMainPatientPagePatient())));
                  }
                  if (selectedCategory == 'Последние записи') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopPatientLastRecordsPagePatient())));
                  }
                  if (selectedCategory == 'Добавить запись') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (DesktopModulesPagePatient())));
                  }
                  if (selectedCategory == 'Статистика') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopStatisticsPatientPagePatient())));
                  }
                });
              }),
        )
        .toList();
  }

  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    List<ModuleModel> modules = (await ApiDataProvider().getAllModules());

    data = (await ApiDataProvider().getStatisctics(
        "a76d9dc1-de4f-11ee-8c0c-00f5f80cf8ae", globals.user!.id));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  List<SfCartesianChart> createChartData() {
    List<SfCartesianChart> graphs = [];
    Map<String, String> dots = {};
    print(data.keys);
    for (var elem in data.keys) {
      List<ChartData> chartData = [];
      for (var it in data[elem]!.keys) {
        chartData
            .add(ChartData(DateTime.parse(it), double.parse(data[elem]![it]!)));
        print(DateTime.parse(it).toString() +
            " " +
            double.parse(data[elem]![it]!).toString());
      }
      print(elem);
      graphs.add(SfCartesianChart(
          palette: [secondColor],
          title: ChartTitle(text: elem),
          primaryXAxis: DateTimeAxis(),
          series: <CartesianSeries<ChartData, DateTime>>[
            // Renders line chart
            LineSeries<ChartData, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ]));
    }
    return graphs;
  }

  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    /* Map<DateTime, double> line1 = {
      DateTime.parse('2012-02-27 13:08:00'): 10,
      DateTime.parse('2012-02-28 17:08:00'): 19,
    };
    Map<DateTime, double> line2 = {
      DateTime.parse('2012-02-27 15:08:00'): 20,
      DateTime.parse('2012-02-29 19:08:00'): 30,
    };
    LineChart chart = LineChart.fromDateTimeMaps([
      line1,
      line2
    ], [
      Colors.green,
      Colors.blue,
    ], [
      'C',
      'C',
    ], tapTextFontWeight: FontWeight.w400);*/

    final List<ChartData> chartData = [
      ChartData(DateTime(2016, 1), 6),
      ChartData(DateTime(2015, 1), 11),
      ChartData(DateTime(2017, 1), 9),
      ChartData(DateTime(2019, 1), 14),
      ChartData(DateTime(2018, 1), 10),
    ];

    return Scaffold(
      appBar: PatientAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getChoiceChips()),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: //[
                        createChartData(),
                    /*SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Param"),
                                ),
                              ],
                            ),
                          ),
                        ),*/
                    /*SfCartesianChart(
                          title: ChartTitle(text: 'Param'),
                          primaryXAxis: DateTimeAxis(),
                          series: <CartesianSeries<ChartData, DateTime>>[
                            // Renders line chart
                            LineSeries<ChartData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ])*/

                    /*SfCartesianChart(
                          title: ChartTitle(text: 'Param 2'),
                          primaryXAxis: DateTimeAxis(),
                          series: <CartesianSeries<ChartData, DateTime>>[
                            // Renders line chart
                            LineSeries<ChartData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),
                      SfCartesianChart(
                          title: ChartTitle(text: 'Param 3'),
                          primaryXAxis: DateTimeAxis(),
                          series: <CartesianSeries<ChartData, DateTime>>[
                            // Renders line chart
                            LineSeries<ChartData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),
                      SfCartesianChart(
                          title: ChartTitle(text: 'Param 4'),
                          primaryXAxis: DateTimeAxis(),
                          series: <CartesianSeries<ChartData, DateTime>>[
                            // Renders line chart
                            LineSeries<ChartData, DateTime>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),*/
                    //],
                  )

                  /*AnimatedLineChart(
                    chart,
                    key: UniqueKey(),
                    gridColor: Colors.black54,
                    textStyle: TextStyle(fontSize: 10, color: Colors.black54),
                    toolTipColor: Colors.white,
                    showMarkerLines: false,
                    verticalMarkerColor: null,
                    verticalMarker: [
                      DateTime.parse('2012-02-27 13:08:00'),
                      DateTime.parse('2012-02-27 13:16:00')
                    ],
                    verticalMarkerIcon: [
                      Icon(
                        Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                      Icon(
                        Icons.check_circle_rounded,
                        color: Colors.green,
                      ),
                    ],
                    iconBackgroundColor: Colors.white,
                    legendsRightLandscapeMode: true,
                  ), //Unique key to force animations
                ),*/

                  /*Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Card(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                            text: patientDataToString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )),*/
                  ),
            ),
            /*)*/
          ],
        ),
      ),
    );
  }
}
