import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ramunisweatherapp/ramunisweatherapp/services/constants.dart';

//
import 'components/weather_item.dart';
import 'hourly_page.dart';
import 'ramunisweatherapp/services/weather.dart';
import 'package:ramunisweatherapp/providers_page.dart';
import 'package:ramunisweatherapp/about_page.dart';
import 'package:ramunisweatherapp/favorite_page.dart';


class HomePage extends StatefulWidget {
  static final String id = 'TestHomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final TextEditingController _cityController = TextEditingController();
   final Constants _constants = Constants();
   late String _cityName;
   late String _windSpeed;
   late String _humidity;
   late String _cloud;
   late String _feelslike;
   var _weatherCode;
   late String _temp;
   late String _tempmin;
   late String _tempmax;
   bool _flag=false;
   var bulkData;

   String currentDate = '';

   @override
   void initState() {
     super.initState();
     _getWeatherDataByLocation();
     DateTime now = DateTime.now();
     var newDate = DateFormat('MMMMEEEEd').format(now);
     currentDate = newDate;
   }

   void _getWeatherDataByLocation() async {
     var data = await Weather.getLocationWeather();
     _cityName = data['name'];
     _temp = data['main']['temp'].toString();
     _tempmin = data['main']['temp_min'].toString();
     _tempmax = data['main']['temp_max'].toString();
     _windSpeed = data['wind']['speed'].toString();
     _humidity = data['main']['humidity'].toString();
     _cloud = data['clouds']['all'].toString();
     _feelslike = data['main']['feels_like'].toString();
     _weatherCode = data['weather'][0]['id'];

     setState(() {
       _flag = true;
     });
   }
   void _getWeatherData(String city) async {
     var data = await Weather.getCityWeather(city);
     _temp = data['main']['temp'].toString();
     _tempmin = data['main']['temp_min'].toString();
     _tempmax = data['main']['temp_max'].toString();
     _windSpeed = data['wind']['speed'].toString();
     _humidity = data['main']['humidity'].toString();
     _cloud = data['clouds']['all'].toString();
     _feelslike = data['main']['feels_like'].toString();
     _weatherCode = data['weather'][0]['id'];

     setState(() {
       _flag = true;
     });
   }

   @override
   Widget build(BuildContext context) {
     //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
         //overlays: SystemUiOverlay.values);
     Size size = MediaQuery.of(context).size;
     if (_flag == false) {
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
     } else {
       return Scaffold(
         appBar: AppBar(title: Text("Weather App")),
         backgroundColor: Colors.white,
         body: Container(
           width: size.width,
           height: size.height,
           padding: const EdgeInsets.only(top:20,left:10,right:10),
           color: _constants.primaryColor.withOpacity(.1),
           child: Column(
             crossAxisAlignment:  CrossAxisAlignment.center,
             children: [
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                 height: size.height*.8,
                 decoration: BoxDecoration(
                   gradient: _constants.linearGradientBlue,
                    boxShadow: [
                      BoxShadow(
                        color: _constants.primaryColor.withOpacity(.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0,3)
                      ),
                   ],
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: Column(
                   //crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Image.asset("assets/menu.png",width:40,height:40),
                         Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Image.asset("assets/ping.png", width: 20,),
                             const SizedBox(width:2,),
                             Text(_cityName, style: const TextStyle(
                               color:Colors.white,
                               fontSize: 16.0,
                             ),),
                             IconButton(onPressed: (){
                               _cityController.clear();
                               showModalBottomSheet(context: context, builder: (context)=> SingleChildScrollView(
                                 controller: ScrollController(),
                                 child: Container(
                                   height: size.height*.2,
                                   padding: const EdgeInsets.symmetric(
                                     horizontal: 20, vertical: 10,
                                   ),
                                   child: Column(
                                     children: [
                                       SizedBox(
                                         width: 70,
                                         child: Divider(
                                           thickness: 3.5,
                                           color: _constants.primaryColor,
                                         ),
                                       ),
                                       const SizedBox(height: 10,),
                                       TextField(
                                         onChanged: (searchText){
                                           _getWeatherData(searchText);
                                           _cityName = searchText;
                                         },
                                         controller: _cityController,
                                         autofocus: true,
                                         decoration: InputDecoration(
                                             prefixIcon: Icon(Icons.search, color: _constants.primaryColor,),
                                             suffixIcon: GestureDetector(
                                               onTap: ()=> _cityController.clear(),
                                               child: Icon(Icons.close,color: _constants.primaryColor,),
                                             ),
                                             hintText: 'Search city',
                                             focusedBorder: OutlineInputBorder(
                                               borderSide: BorderSide(
                                                 color: _constants.primaryColor,
                                               ),
                                               borderRadius: BorderRadius.circular(10),
                                             )
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ));
                             }, icon: const Icon(Icons.keyboard_arrow_down,color: Colors.white,))
                           ],
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 160,
                       child: Image.asset(Weather.getWeatherPicture(_weatherCode)),
                     ),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 8.0),
                           child: Text(
                             _temp,
                             style:TextStyle(
                                 fontSize: 80,
                                 fontWeight: FontWeight.bold,
                                 foreground: Paint()..shader = _constants.shader,
                             ),
                           ),
                         ),
                         Text(
                           'o',
                           style:TextStyle(
                             fontSize: 40,
                             fontWeight: FontWeight.bold,
                             foreground: Paint()..shader = _constants.shader,
                           ),
                         ),
                       ],
                     ),
                     Text(Weather.getWeatherHint(_weatherCode), style: const TextStyle(
                       color: Colors.white70,
                       fontSize: 20.0,
                     ),),
                     Text(_tempmin+"°/ "+_tempmax+"° Feels Like "+_feelslike+"°", style: const TextStyle(
                       fontSize: 15,
                       color: Colors.white70,
                     ),),
                     Text(currentDate, style: const TextStyle(
                       color: Colors.white70,
                     ),),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       child: const Divider(
                         color: Colors.white70,
                       ),
                     ),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 40),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                       WeatherItem(
                         text: "WindSpeed",
                         value: _windSpeed,
                         unit: 'km/h',
                         imageUrl: 'assets/windspeed.png',
                        ),
                         WeatherItem(
                           text: "Humidity",
                           value: _humidity,
                           unit: '%',
                           imageUrl: 'assets/humidity.png',
                         ),
                         WeatherItem(
                           text: "Chance of Rain",
                           value: _cloud,
                           unit: '%',
                           imageUrl: 'assets/cloud.png',
                         ),
                       ],
                    ),
                     ),
                   ],
                 ),
               ),
           //
               Container(
                 padding: const EdgeInsets.only(top: 1),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text(
                           'Today',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 20.0,
                           ),
                         ),
                         GestureDetector(
                           onTap: () =>
                               Navigator.push(context,MaterialPageRoute(builder: (_) => MyApp(fav: _cityName))), //this will open forecast screen
                           child: Text(
                             'Forecasts',
                             style: TextStyle(
                               fontWeight: FontWeight.w600,
                               fontSize: 16,
                               color: _constants.primaryColor,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ],


               //
                 )
               )
             ],
           )
         ),


         drawer: Drawer(
           child: ListView(
             // Important: Remove any padding from the ListView.
             padding: EdgeInsets.zero,
             children: <Widget>[
           UserAccountsDrawerHeader(
           accountName: Text("Ramunis"),
           accountEmail: Text("Weather Application"),
           ),
           ListTile(
                 leading: Icon(Icons.home), title: Text("Главная"),
                 onTap: () {
                   Navigator.pop(context);
                 },
               ),
               ListTile(
                 leading: Icon(Icons.grade), title: Text("Избранное"),
                 onTap: () {
                   Navigator.push(
                       context, MaterialPageRoute(builder: (_) => Favorite()));
                 },
               ),
               ListTile(
                 leading: Icon(Icons.cloud), title: Text("Поставщики данных"),
                 onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (_) => Providers()));
                 },
               ),
               ListTile(
                 leading: Icon(Icons.build), title: Text("О приложении"),
                 onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (_) => About()));
                 },
               ),
             ],
           ),
         ),
       //  ),
       );


     }
   }
}

