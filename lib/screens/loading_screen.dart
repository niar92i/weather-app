import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/services/current_weather_service.dart';
import 'package:weather_app/utils/my_utils.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  void getWeatherData() async {
    await MyUtils.getLocationData();

    CurrentWeatherService weatherData = CurrentWeatherService(locationData: MyUtils.locationData);
    await weatherData.getCurrentWeather();

    if (weatherData.data == null) {
      // TODO : Handle no weather
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return MainScreen(weatherData: weatherData,);
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
