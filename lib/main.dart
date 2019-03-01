import 'package:digitalweather/src/blocs/theme_bloc.dart';
import 'package:digitalweather/src/widgets/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<App> createState() {
    return new _AppState();
  }
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    //BlocProvider to make our ThemeBloc globally available using BlocProvider.of<ThemeBloc>(context).
    return BlocProvider(
      bloc: _themeBloc,
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Digital Weather',
            color: Colors.black,
            home: Weather(
              weatherRepository: widget.weatherRepository,
            ),
          );
        },
      ),
    );
  }

  @override 
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }
}
