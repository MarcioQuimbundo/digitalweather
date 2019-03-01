import 'package:digitalweather/src/widgets/temperature.dart';
import 'package:digitalweather/src/widgets/weather_conditions.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:digitalweather/src/models/weather_model.dart' as model;


class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  CombinedWeatherTemperature({Key key, @required this.weather}) : assert(weather != null), super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: WeatherConditions(condition: weather.condition),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Temperature(
                  temperature: weather.temp,
                  high: weather.maxTemp,
                  low: weather.minTemp,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              weather.formattedCondition,
              style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
