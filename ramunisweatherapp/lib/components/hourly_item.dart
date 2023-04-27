import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramunisweatherapp/ramunisweatherapp/services/constants.dart';
import 'package:ramunisweatherapp/models/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  const WeatherItem(
      {super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final Constants _constants = Constants();
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(new DateFormat.yMMMd().format(weather.date),style: const TextStyle(
                  color: Color(0xff6696f5),
                  fontWeight: FontWeight.w600,
                ),),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('${weather.temp.toString()}',
                          style: TextStyle(
                            color: _constants.blackColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text("°F",
                          style: TextStyle(
                              color: _constants.blackColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFeatures: const [
                                FontFeature.enable('sups'),
                              ]
                          ),
                        ),


                      ],
                    ),
                  ],
                ),

              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 5,),
                    Text(new DateFormat.Hm().format(weather.date),style:const TextStyle(
                      fontSize: 16,
                      color:Colors.grey,
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(weather.main,style:const TextStyle(
                      fontSize: 18,
                      color:Colors.grey,
                    ),),
                    const SizedBox(width: 5,),
                    Image.network('https://openweathermap.org/img/w/${weather.icon}.png')                  ],
                ),
              ],
            ),
          ],
        ),),
    );
  }
}