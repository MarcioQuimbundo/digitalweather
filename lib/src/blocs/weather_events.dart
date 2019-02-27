import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const[]]) : super(props);
}

class FetchWeather extends WeatherEvent {
  final String city;

  FetchWeather({@required this.city}) : assert(city != null), super([city]);
}