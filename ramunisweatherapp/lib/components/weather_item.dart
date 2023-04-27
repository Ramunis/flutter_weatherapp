import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String text;
  final String value;
  final String unit;
  final String imageUrl;

  const WeatherItem({
  super.key, required this.text, required this.value, required this.unit, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),),
        Container(
          padding: const EdgeInsets.all( 10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(imageUrl,),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          value.toString() + unit,style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      ],
    );
  }
}