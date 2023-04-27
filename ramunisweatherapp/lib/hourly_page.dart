import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'components/hourly_item.dart';
import 'package:ramunisweatherapp/models/ForecastData.dart';

class MyApp extends StatefulWidget {
  final fav;

  const MyApp({Key? key, this.fav}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  late ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather(widget.fav);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      );
    } else
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          backgroundColor: Colors.greenAccent,
          appBar: AppBar(
            title: Text('Hourly Forecast'),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child:Column(
                children: <Widget>[
                  Container(
                    height: 550.0,
                    child: forecastData != null ? ListView.builder(
                        itemCount: forecastData.list.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                    ) : Container(),
                  ),
                ],
              )
          )
      ),
    );
  }

  loadWeather(String city) async {
    setState(() {
      isLoading = true;
    });

    final forecastResponse = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=${city
            .toString()}&APPID=a0fff5baeda20538ce0c29c3b57c2209'));

    if (forecastResponse.statusCode == 200) {
      return setState(() {
        forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
