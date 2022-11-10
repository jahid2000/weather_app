import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp,description, currently, humidity, windSpeed;

  Future getData() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Rajshahi&units=metric&appid=9a8aecb6395eb0eb807191d06386c3a9"));
    var results = jsonDecode(response.body);
    setState(() {
      temp = (results['main']['temp']).toStringAsFixed(2);
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Weather App'),

          ),
          body: Column(
            children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: <Widget>[

                      Text(
                      "Weather at Rajshahi",
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize:15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                      Text(
                        temp!=null?"Temperature: "+temp+"\u00B0C":"temperature is loading...",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize:18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                     Text (
                      currently!=null ? currently.toString() : "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    ],
                ),
                ),
            ],
    ),
        ),
    );
  }
}