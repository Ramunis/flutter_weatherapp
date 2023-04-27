import 'package:flutter/material.dart';

class About extends StatefulWidget {
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Container(
        padding: const EdgeInsets.only(top:10,left:10,right:10),
        child: Column(
          children: [
            Text('Погодное приложение',style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),),
            Text('Разработал Студент группы М9122-01.04.02пи Магистратуры ДВФУ Рамунис С.Ю и КО',style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),),
            Text('Версия 1.0',style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),),
            Image.asset("assets/logo.png",width: 220, height: 140),
            Text('Скомпилирован в Android Studio 4.1.2',style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),),
            Text('Разработан на фреймворке Flutter',style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),),
            Image.asset("assets/flutter.png"),
          ],
        ),
      ),
    );
  }
}