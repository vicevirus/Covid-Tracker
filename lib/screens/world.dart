import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:http/http.dart' as http;
import 'worldgraphdetail.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'dart:convert';
import 'dart:async';

class WorldScreen extends StatefulWidget {
  
  final int title;
  final String message;

  const WorldScreen({Key key, this.title, this.message}) : super(key: key);

  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  var data;
  var countrycount;
  var countryname;

  Future getData() async {
    http.Response response =
        await http.get("https://corona.lmao.ninja/countries");
    data = await json.decode(response.body);

    setState(() {
      countrycount = data.length;
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
        backgroundColor: Color(0xFFFF353839),
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: countrycount == null ? 0 : countrycount,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: GradientCard(
                        elevation: 8,
                        shadowColor:
                            Gradients.hotLinear.colors.last.withOpacity(0.25),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorldGraphDetail(indexnumber: index,)));
                          },
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: AutoSizeText(
                                      data[index]['country'],
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(width: 60),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    data[index]['cases'].toString(),
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.indigoAccent,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    " Cases",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                            ],
                          )),
                        )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
