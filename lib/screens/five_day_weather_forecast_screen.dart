import 'package:flutter/material.dart';

class FiveDayWeatherForecastScreen extends StatefulWidget {
  const FiveDayWeatherForecastScreen({super.key});

  @override
  State<FiveDayWeatherForecastScreen> createState() => _FiveDayWeatherForecastScreenState();
}

class _FiveDayWeatherForecastScreenState extends State<FiveDayWeatherForecastScreen> {
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
