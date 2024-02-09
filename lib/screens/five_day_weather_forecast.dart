import 'package:flutter/material.dart';

class FiveDayWeatherForecast extends StatefulWidget {
  const FiveDayWeatherForecast({super.key});

  @override
  State<FiveDayWeatherForecast> createState() => _FiveDayWeatherForecastState();
}

class _FiveDayWeatherForecastState extends State<FiveDayWeatherForecast> {
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
          title: const Text('5 days weather forecasts'),
          // centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
