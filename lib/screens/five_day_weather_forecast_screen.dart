import 'package:flutter/material.dart';
import 'package:weather_app/controllers/five_day_weather_forecast_controller.dart';
import 'package:weather_app/services/five_day_weather_forecasts_service.dart';

import '../data/models/weather_forecast_model.dart';
import '../utils/my_utils.dart';

class FiveDayWeatherForecastScreen extends StatefulWidget {
  const FiveDayWeatherForecastScreen({super.key, required this.weatherForecastsDataList});
  final Future<List<WeatherForecastModel>> weatherForecastsDataList;

  @override
  State<FiveDayWeatherForecastScreen> createState() => _FiveDayWeatherForecastScreenState();
}

class _FiveDayWeatherForecastScreenState extends State<FiveDayWeatherForecastScreen> {

  FiveDayWeatherForecastController fiveDayWeatherForecastController = FiveDayWeatherForecastController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        body:
        FutureBuilder<List<WeatherForecastModel>>(
          future: widget.weatherForecastsDataList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Aucune donnée trouvée');
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return WeatherForecastCard(snapshot.data![index]);
                },
              );
            }
          },
        ),




        ),
    );
  }
}

class WeatherForecastCard extends StatelessWidget {
  final WeatherForecastModel weatherForecast;

  const WeatherForecastCard(this.weatherForecast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Date/Time: ${weatherForecast.formattedDateTime}'),
            Text('Temperature: ${weatherForecast.temperature}'),
            Text('Weather: ${weatherForecast.weatherDescription}'),
            Text('Icon: ${weatherForecast.iconCode}'),
          ],
        ),
      ),
    );
  }
}