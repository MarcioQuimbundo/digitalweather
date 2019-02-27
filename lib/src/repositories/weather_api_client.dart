import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:digitalweather/src/models/weather_model.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('Erro ao pegar o locationId para cidade');
    }

    final locationJson =jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('Erro ao pegar o tempo da localização');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}