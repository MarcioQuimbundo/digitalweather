import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digitalweather/src/widgets/widgets.dart';
import 'package:digitalweather/src/repositories/repositories.dart';
import 'package:digitalweather/src/blocs/blocs.dart';

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
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
            },
          ),*/
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
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: BlocBuilder(
            bloc: _weatherBloc,
            builder: (_, WeatherState state) {
              if (state is WeatherEmpty) {
                return Center(child: Text('Por favor, selecione uma cidade'));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;
                
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Center(
                        child: Location(location: weather.location),
                      ),
                    ),
                    Center(
                      child: LastUpdated(dateTime: weather.lastUpdated),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(
                        child: CombinedWeatherTemperature(weather: weather,),
                      ),
                    ),
                  ],
                );

              }
              if (state is WeatherError) {
                return Text(
                  'Ups, alguma coisa correu mal!',
                  style: TextStyle(color: Colors.red),
                );
              }
            },
          ),
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