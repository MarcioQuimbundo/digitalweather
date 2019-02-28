import 'package:digitalweather/src/blocs/weather_events.dart';
import 'package:digitalweather/src/blocs/weather_states.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:digitalweather/src/repositories/weather_repository.dart';
import 'package:digitalweather/src/models/weather_model.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository weatherRepository;
  
  WeatherBloc({@required this.weatherRepository}) : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherState currentState,
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}