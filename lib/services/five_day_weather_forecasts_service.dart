
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:weather_app/data/constants/const.dart';
import 'package:weather_app/data/models/weather_forecast_model.dart';
import 'package:weather_app/utils/location.dart';

class FiveDayWeatherForecastsService {
  FiveDayWeatherForecastsService({required this.locationData});

  LocationHelper locationData;

  late String data;
  late List<WeatherForecastModel> forecasts;

  Future<void> getFiveDayWeatherForecasts() async {
    Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/forecast?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      data = response.body;
      var fiveDayWeatherForecasts = jsonDecode(data);

      try {
         forecasts = List.from(fiveDayWeatherForecasts['list'].map((json) => WeatherForecastModel.fromJson(json)));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      print('Could not fetch weather forecasts data');
    }
  }
}