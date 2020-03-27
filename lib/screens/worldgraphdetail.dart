import 'package:fl_chart/fl_chart.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

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
  var datanow;
  var historicaldata;
  var countryname;
  var totalcases;
  var todaycases;
  var deaths;
  var todaydeaths;
  var recovered;
  var active;
  var critical;
  var now = new DateTime.now();
  var firstdayformatAPI;
  var seconddayformatAPI;
  var thirddayformatAPI;
  var fourthdayformatAPI;
  var fifthdayformatAPI;
  var todayformatAPI;
  var firstdayformatDIS;
  var seconddayformatDIS;
  var thirddayformatDIS;
  var fourthdayformatDIS;
  var fifthdayformatDIS;
  var todayformatDIS;
  var firstday;
  var secondday;
  var thirdday;
  var fourthday;
  var fifthday;
  var today;
  var firstdaydate;
  var seconddaydate;
  var thirddaydate;
  var fourthdaydate;
  var fifthdaydate;
  var todaydate;
  final dateformatterforapi = DateFormat('M/dd/yy');
  final dateformatterfordisplay = DateFormat('dd/MM');

  Future getData() async {
    http.Response response1 =
        await http.get("https://corona.lmao.ninja/countries");
    datanow = await json.decode(response1.body);

    setState(() {
      countryname = datanow[widget.indexnumber]['country'];

      if (countryname == "Iran, Islamic Republic of") {
        countryname = "Iran";

      }

      totalcases = datanow[widget.indexnumber]['cases'];
      todaycases = datanow[widget.indexnumber]['todayCases'];
      deaths = datanow[widget.indexnumber]['deaths'];
      todaydeaths = datanow[widget.indexnumber]['todayDeaths'];
      recovered = datanow[widget.indexnumber]['recovered'];
      active = datanow[widget.indexnumber]['active'];
      critical = datanow[widget.indexnumber]['critical'];

      getHistoricalData(countryname);
    });
  }

  Future getHistoricalData(String country) async {
    firstdaydate = now.subtract(Duration(days: 5));
    firstdayformatAPI = dateformatterforapi.format(firstdaydate);
    firstdayformatDIS = dateformatterfordisplay.format(firstdaydate);

    seconddaydate = now.subtract(Duration(days: 4));
    seconddayformatAPI = dateformatterforapi.format(seconddaydate);
    seconddayformatDIS = dateformatterfordisplay.format(seconddaydate);

    thirddaydate = now.subtract(Duration(days: 3));
    thirddayformatAPI = dateformatterforapi.format(thirddaydate);
    thirddayformatDIS = dateformatterfordisplay.format(thirddaydate);

    fourthdaydate = now.subtract(Duration(days: 2));
    fourthdayformatAPI = dateformatterforapi.format(fourthdaydate);
    fourthdayformatDIS = dateformatterfordisplay.format(fourthdaydate);

    fifthdaydate = now.subtract(Duration(days: 1));
    fifthdayformatAPI = dateformatterforapi.format(fifthdaydate);
    fifthdayformatDIS = dateformatterfordisplay.format(fifthdaydate);

    todaydate = now;
    todayformatAPI = dateformatterforapi.format(todaydate);
    todayformatDIS = dateformatterfordisplay.format(todaydate);

    http.Response response2 =
        await http.get("https://corona.lmao.ninja/v2/historical/$country");
    historicaldata = await json.decode(response2.body);

    setState(() {
      
      firstday = historicaldata['timeline']['cases'][firstdayformatAPI];
      secondday = historicaldata['timeline']['cases'][seconddayformatAPI];
      thirdday = historicaldata['timeline']['cases'][thirddayformatAPI];
      fourthday = historicaldata['timeline']['cases'][fourthdayformatAPI];
      fifthday = historicaldata['timeline']['cases'][fifthdayformatAPI];
      today = historicaldata['timeline']['cases'][todayformatAPI];
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
                    
                  },
                  child: Text(
                    countryname == null ? "" : countryname,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                color: const Color(0xff2c4260),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: totalcases == null ? 0 : totalcases.toDouble() + 10000 ,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBottomMargin: 1,
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
                        margin: 10,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return firstdayformatDIS == null ? "" : firstdayformatDIS.toString();
                            case 1:
                              return seconddayformatDIS == null ? "" : seconddayformatDIS.toString();
                            case 2:
                              return thirddayformatDIS == null ? "" : thirddayformatDIS.toString();
                            case 3:
                              return fourthdayformatDIS == null ? "" : fourthdayformatDIS.toString();
                            case 4:
                              return fifthdayformatDIS == null ? "" : fifthdayformatDIS.toString();
                            case 5:
                              return todayformatDIS == null ? "" : todayformatDIS.toString();
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
                            y: firstday == null ? 0 : firstday.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(
                            y: secondday == null ? 0 : secondday.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(
                            y: thirdday == null ? 0 : thirdday.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: fourthday == null ? 0 : fourthday.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: fifthday == null ? 0 : fifthday.toDouble(),
                            color: Colors.lightBlueAccent)
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(
                            y: totalcases == null ? 0 : totalcases.toDouble(),
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
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  )),
              Card(
                color: Colors.redAccent,
                child: Text(
                  "Today Cases:" + todaycases.toString(),
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              Card(
                color: Colors.black,
                child: Text(
                  "Total Deaths: " + deaths.toString(),
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              Card(
                color: Colors.black,
                child: Text(
                  "Today Deaths: " + todaydeaths.toString(),
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
              Card(
                color: Colors.greenAccent,
                child: Text(
                  "Recovered: " + recovered.toString(),
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
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
                  "Critical: " + critical.toString(),
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
