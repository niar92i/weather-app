
import 'dart:convert';

import 'package:http/http.dart';

import '../data/models/region_weather_model.dart';

const apiKey = '8b46867d4c29461a7f27c8ffbad0b288';

class MyUtils {

  static Future<List<RegionWeatherModel>> fetchCountryWeatherData(
      List<String> latitudes, List<String> longitudes) async {
    List<RegionWeatherModel> countryWeatherList = [];
    for (int i = 0; i < latitudes.length; i++) {
      final response = await get(Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=${latitudes[i]}&lon=${longitudes[i]}&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        RegionWeatherModel countryWeather = RegionWeatherModel(
          iconWeather: data['weather'][0]['icon'],
          weatherDescription: data['weather'][0]['description'],
          temperature: data['main']['temp'],
          locationName: data['name'],
        );
        countryWeatherList.add(countryWeather);
      } else {
        throw Exception('Erreur de chargement des données');
      }
    }
    return countryWeatherList;
  }
}