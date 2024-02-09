import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:weather_app/utils/location.dart';
import 'package:weather_app/utils/weather_data.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // TODO : Handle no location
    }

    print(locationData.longitude);
    print(locationData.latitude);
  }
  
  void getWeatherData() async {
    await getLocationData();
    
    WeatherData weatherData = WeatherData(locationData: locationData);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
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
