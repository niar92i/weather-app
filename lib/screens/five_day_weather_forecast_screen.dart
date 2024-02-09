import 'package:flutter/material.dart';
import 'package:weather_app/controllers/five_day_weather_forecast_controller.dart';
import 'package:weather_app/services/five_day_weather_forecasts_service.dart';

import '../utils/my_utils.dart';

class FiveDayWeatherForecastScreen extends StatefulWidget {
  const FiveDayWeatherForecastScreen({super.key});

  @override
  State<FiveDayWeatherForecastScreen> createState() => _FiveDayWeatherForecastScreenState();
}

class _FiveDayWeatherForecastScreenState extends State<FiveDayWeatherForecastScreen> {

  FiveDayWeatherForecastController fiveDayWeatherForecastController = FiveDayWeatherForecastController();

  late FiveDayWeatherForecastsService weatherForecastsData;

  @override
  void initState() {
    // TODO: implement initState
    getFiveDayWeatherForecast();
    super.initState();
  }

  void getFiveDayWeatherForecast() async {
    weatherForecastsData = FiveDayWeatherForecastsService(locationData: MyUtils.locationData);
    await weatherForecastsData.getFiveDayWeatherForecasts();

    if (weatherForecastsData.data == null) {
      // TODO : Handle no data
    } else {
      fiveDayWeatherForecastController.weatherForecastsData = weatherForecastsData.forecasts;
      for (var forecast in fiveDayWeatherForecastController.weatherForecastsData) {
        print('Date/Time: ${forecast.dateTimeUnix}, Temperature: ${forecast.iconCode}, Weather: ${forecast.weatherDescription}, Icon: ${forecast.temperature}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          )),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('5 days weather forecasts', style: TextStyle(fontSize: 16),),
          // centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
