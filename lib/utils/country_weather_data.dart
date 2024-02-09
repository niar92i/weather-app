import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

const apiKey = '8b46867d4c29461a7f27c8ffbad0b288';

class CountryWeatherData {

  late String currentIcon;
  late double currentTemperature;
  late String currentDescription;

  Future<void> getCurrentCountryWeather(double longitude, double latitude) async {

    Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric')
    );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentDescription = currentWeather['weather'][0]['description'];
        String iconId = currentWeather['weather'][0]['icon'];
        currentIcon = 'https://openweathermap.org/img/wn/$iconId@2x.png';
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }
}