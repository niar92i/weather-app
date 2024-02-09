import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/controllers/loading_screen_controller.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/services/weather_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  LoadingScreenController loadingScreenController = LoadingScreenController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    await loadingScreenController.getLocationData();

    WeatherData weatherData = WeatherData(locationData: loadingScreenController.locationData);
    await weatherData.getCurrentWeather();

    if (weatherData.currentTemperature == null) {
      // TODO : Handle no weather
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return MainScreen(weatherData: weatherData);
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple, Colors.blue],
        )),
        child: const SpinKitRipple(
          color: Colors.white,
          duration: Duration(milliseconds: 1400),
          size: 150,
        ),
      ),
    );
  }
}
