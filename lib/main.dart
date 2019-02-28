import 'package:digitalweather/src/widgets/weather.dart';
import 'package:http/http.dart' as http;
import 'package:digitalweather/src/repositories/weather_api_client.dart';
import 'package:digitalweather/src/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Transition transition) {
    print(transition);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository:weatherRepository));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository}) : assert(weatherRepository != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Weather',
      home: Weather(
        weatherRepository:weatherRepository,
      ),
    );
  }
}