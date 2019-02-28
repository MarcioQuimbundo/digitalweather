import 'dart:async';

import 'package:digitalweather/src/blocs/weather_events.dart';
import 'package:digitalweather/src/blocs/weather_states.dart';
import 'package:digitalweather/src/widgets/city_selection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digitalweather/src/widgets/weather.dart';
import 'package:digitalweather/src/repositories/weather_api_client.dart';
import 'package:digitalweather/src/repositories/weather_repository.dart';
import 'package:digitalweather/src/blocs/weather_bloc.dart';

class Weather extends StatefulWidget {
  final WeatherRepository weatherRepository;

  Weather({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherBloc _weatherBloc;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                _weatherBloc.dispatch(FetchWeather(city: city));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (_, WeatherState state){
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'),);
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator(),);
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;

              return ListView(

              );
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }
}
