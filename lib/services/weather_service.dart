import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/utils/location.dart';

const apiKey = '8b46867d4c29461a7f27c8ffbad0b288';

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  late double currentTemperature;
  late int currentHumidity;
  late double currentFeelsLikeTemperature;
  late int currentCloudsDensity;
  late int currentCondition;
  late int sunrise;
  late int sunset;
  late String currentPosition;
  late String currentDescription;
  late String currentIconCode;
  late String currentCountry;
  late double currentWindSpeed;

  Future<void> getCurrentWeather() async {

    Response response = await get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric')
        );

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentHumidity = currentWeather['main']['humidity'];
        currentFeelsLikeTemperature = currentWeather['main']['feels_like'];
        currentCloudsDensity = currentWeather['clouds']['all'];
        currentCountry = currentWeather['sys']['country'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentDescription = currentWeather['weather'][0]['description'];
        currentIconCode = currentWeather['weather'][0]['icon'];
        currentWindSpeed = currentWeather['wind']['speed'];
        sunset = currentWeather['sys']['sunset'];
        sunrise = currentWeather['sys']['sunrise'];
        currentPosition = currentWeather['name'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch weather data');
    }
  }
}
