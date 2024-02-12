import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/five_day_weather_forecast_controller.dart';
import 'package:weather_app/controllers/main_screen_controller.dart';
import '../data/models/weather_forecast_model.dart';
import '../services/current_weather_service.dart';

class FiveDayWeatherForecastScreen extends StatefulWidget {
  const FiveDayWeatherForecastScreen(
      {super.key, required this.weatherForecastsDataList,});

  final Future<List<WeatherForecastModel>> weatherForecastsDataList;

  @override
  State<FiveDayWeatherForecastScreen> createState() =>
      _FiveDayWeatherForecastScreenState();
}

class _FiveDayWeatherForecastScreenState
    extends State<FiveDayWeatherForecastScreen> {
  FiveDayWeatherForecastController fiveDayWeatherForecastController =
      FiveDayWeatherForecastController();

  MainScreenController mainScreenController = MainScreenController();

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
          title: const Text(
            '5 days weather forecasts',
            style: TextStyle(fontSize: 16),
          ),
          // centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(25),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.deepPurple.withOpacity(0.3),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          // Image.network(
                          //   'https://openweathermap.org/img/wn/${weatherData.currentIconCode}@2x.png',
                          //   fit: BoxFit.contain,
                          //   width: 125,
                          //   height: 125,
                          //   // scale: ,
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<List<WeatherForecastModel>>(
              future: widget.weatherForecastsDataList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Aucune donnée trouvée');
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 5.0,
                        crossAxisCount: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return WeatherForecastWidget(snapshot.data![index]);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherForecastWidget extends StatelessWidget {
  final WeatherForecastModel weatherForecast;

  WeatherForecastWidget(this.weatherForecast, {super.key});

  FiveDayWeatherForecastController fiveDayWeatherForecastController =
      FiveDayWeatherForecastController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      // color: Colors.blue,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                fiveDayWeatherForecastController.getDayOfWeek(
                    DateTime.fromMillisecondsSinceEpoch(
                            weatherForecast.dateTimeUnix * 1000)
                        .weekday),
                style: const TextStyle(fontSize: 16),
              ),
              Text(DateFormat("HH:mm a").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      weatherForecast.dateTimeUnix * 1000))),
            ],
          ),
          SizedBox(
            width: 120,
            child: Stack(
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weatherForecast.iconCode}@2x.png',
                  fit: BoxFit.contain,
                  width: 90,
                  height: 90,
                ),
                Container(
                    // color: Colors.blue,
                    margin: const EdgeInsets.only(left: 70),
                    alignment: Alignment.centerLeft,
                    child: Text(weatherForecast.weatherDescription)),
              ],
            ),
          ),
          Text(
            '${weatherForecast.temperature.round().toString()}°',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
