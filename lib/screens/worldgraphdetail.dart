import 'package:fl_chart/fl_chart.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldGraphDetail extends StatefulWidget {
  final int indexnumber;
  const WorldGraphDetail({
    Key key,
    this.indexnumber,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => WorldGraphDetailState();
}

class WorldGraphDetailState extends State<WorldGraphDetail> {
  var data;
  var countryname;
  var totalcases;
  var todaycases;
  var deaths;
  var todaydeaths;
  var recovered;
  var active;
  var critical;

  Future getData() async {
    http.Response response =
        await http.get("https://corona.lmao.ninja/countries");
    data = await json.decode(response.body);

    setState(() {
      countryname = data[widget.indexnumber]['country'];
      totalcases = data[widget.indexnumber]['cases'];
      todaycases = data[widget.indexnumber]['todayCases'];
      deaths = data[widget.indexnumber]['deaths'];
      todaydeaths = data[widget.indexnumber]['todayDeaths'];
      recovered = data[widget.indexnumber]['recovered'];
      active = data[widget.indexnumber]['active'];
      critical = data[widget.indexnumber]['critical'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 1.7,
        child: Scaffold(
          backgroundColor: Color(0xFFFF353839),
          body: ListView(
            
            children: <Widget>[
              GradientCard(
                child: FlatButton(
                  onPressed: () {
                    print(data);
                  },
                  child: Text(
                    countryname == null ? "" : countryname,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff2c4260),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY:
                        totalcases == null ? 0 : totalcases.toDouble() + 10000,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBottomMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            color: const Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Total';
                            case 1:
                              return 'Today';
                            case 2:
                              return 'Deaths';
                            case 3:
                              return 'Recovered';
                            case 4:
                              return 'Active';
                            case 5:
                              return 'Critical';
                            default:
                              return '';
                          }
                        },
                      ),
                      leftTitles: const SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : totalcases.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : todaycases.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : deaths.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : recovered.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : active.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: critical == null ? 0 : critical.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                    ],
                  ),
                ),
              ),
              Card(
                  color: Colors.redAccent,
                  child: Text(
                    "Total Cases: " + totalcases.toString(),
                    style: TextStyle(fontSize: 30.0,
                    color: Colors.white),
                  )),
              Card(
                color: Colors.redAccent,
                child: Text(
                  "Today Cases:" + todaycases.toString(),
                  
                  style: TextStyle(fontSize: 30.0,color: Colors.white),
                ),
              ),
              Card(
                color: Colors.black,
                child: Text(
                  "Total Deaths: " + deaths.toString(),
                  style: TextStyle(fontSize: 30.0,color: Colors.white),
                ),
              ),
              Card(
                color: Colors.black,
                child: Text(
                  "Today Deaths: " + todaydeaths.toString(),
                  style: TextStyle(fontSize: 30.0,color: Colors.white),
                ),
              ),
              Card(
                color: Colors.greenAccent,
                child: Text(
                  "Recovered: " + recovered.toString(),
                  style: TextStyle(fontSize: 30.0,),
                ),
              ),
              Card(
                color: Colors.amber,
                child: Text(
                  "Active: " + active.toString(),
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              Card(
                color: Colors.red,
                child: Text(
                  "Critical: " + critical.toString() ,
                  style: TextStyle(fontSize: 30.0,color: Colors.white ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
