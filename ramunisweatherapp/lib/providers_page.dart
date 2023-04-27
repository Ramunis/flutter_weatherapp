import 'package:flutter/material.dart';

class Providers extends StatefulWidget {
  ProvidersState createState() => ProvidersState();
}

class ProvidersState extends State<Providers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Providers")),
      body: Container(
        padding: const EdgeInsets.only(top:10,left:10,right:10),
        child: Column(
          children: [
            Text('Поставщики данных',style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),),
            Text('Прогноз по геолокации, запрошенному городу, текущие условия, карты погоды получены по открытому API от openweathermap.org',style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),),
            Image.asset("assets/source.png", fit:BoxFit.fill),
          ],
        ),
      ),
    );
  }
}