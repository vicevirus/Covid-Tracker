import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_widgets/gradient_widgets.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final f = new DateFormat('yyyy-MM-dd');

  var data;
  var globalcases;
  var globaldeaths;
  var globalrecovered;
  var lastupdated;
  var lastupdatedformat;
  var dateformat;

  Future getData() async {
    http.Response response = await http.get("https://corona.lmao.ninja/all");
    data = await json.decode(response.body);

    setState(() {
      globalcases = data['cases'];
      globaldeaths = data['deaths'];
      globalrecovered = data['recovered'];
      lastupdated = data['updated'];
      lastupdatedformat =
          f.format(DateTime.fromMillisecondsSinceEpoch(lastupdated));
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
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: Text(
          "Do note that the data may not be updated as fast as your local medical institution",
          textAlign: TextAlign.center,
        )),
        backgroundColor: Color(0xFFFF353839),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.indigoAccent,
              child: Column(
                children: <Widget>[
                  Text(
                    "COVID-19 Status",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'simplifica',
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            GradientCard(
                gradient: Gradients.backToFuture,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Global Cases",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      data == null ? "" : globalcases.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                )),
            GradientCard(
                gradient: Gradients.deepSpace,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Deaths",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Text(
                      data == null ? "" : globaldeaths.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    )
                  ],
                )),
            GradientCard(
                gradient: Gradients.coldLinear,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Recovered",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      data == null ? "" : globalrecovered.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    )
                  ],
                )),
            GradientCard(
                gradient: Gradients.byDesign,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Last Updated",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      data == null ? "" : lastupdatedformat.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )
                  ],
                )),
            SizedBox(height: 60),
            FlatButton(
              onPressed: () {
                getData();
                Navigator.pushNamed(context, '/world');
              },
              child: GradientCard(
                elevation: 8,
                shadowColor: Gradients.hotLinear.colors.last.withOpacity(0.25),
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Check by Country ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
