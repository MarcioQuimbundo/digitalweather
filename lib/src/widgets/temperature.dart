import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:digitalweather/src/models/weather_model.dart' as model;

class Temperature extends StatelessWidget {
  final double temperature;
  final double high;
  final double low;

  Temperature({Key key, @required this.temperature, @required this.high, @required this.low}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Text(
            '${_formattedTemperature(temperature)}º',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Text(
              'max: ${_formattedTemperature(high)}º',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
            Text(
              'min: ${_formattedTemperature(low)}º',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }

  int _formattedTemperature(double t) => t.round();
}