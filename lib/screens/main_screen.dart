import 'dart:core';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/controllers/main_screen_controller.dart';
import 'package:weather_app/screens/five_day_weather_forecast_screen.dart';
import 'package:weather_app/screens/loading_screen.dart';
import 'package:weather_app/services/five_day_weather_forecasts_service.dart';
import 'package:weather_app/utils/my_utils.dart';
import 'package:weather_app/services/current_weather_service.dart';
import 'package:weather_icons/weather_icons.dart';

import '../data/constants/const.dart';
import '../data/models/region_weather_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.weatherData});

  final CurrentWeatherService weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenController mainScreenController = MainScreenController();
  MenuItem? selectedMenu;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  void updateDisplayInfo(CurrentWeatherService weatherData) {
    setState(() {
      mainScreenController.temperature = weatherData.currentTemperature.round();
      mainScreenController.humidity = weatherData.currentHumidity.round();
      mainScreenController.feelsLikeTemperature =
          weatherData.currentFeelsLikeTemperature.round();
      mainScreenController.location = weatherData.currentPosition;
      mainScreenController.country = weatherData.currentCountry;
      mainScreenController.iconCode = weatherData.currentIconCode;
      mainScreenController.description =
          weatherData.currentDescription[0].toUpperCase() +
              weatherData.currentDescription.substring(1);
      mainScreenController.windSpeed = weatherData.currentWindSpeed.round();
      mainScreenController.cloudsDensity = weatherData.currentCloudsDensity;
      mainScreenController.sunriseUnix = weatherData.sunrise;
      mainScreenController.sunsetUnix = weatherData.sunset;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mainScreenController.sunriseTimeDifference.isNegative) {
      mainScreenController.formattedSunriseTimeDifference =
          '(${-mainScreenController.sunriseTimeDifference.inHours} h ago)';
      mainScreenController.formattedSunsetTimeDifference =
          '(In ${mainScreenController.sunsetTimeDifference.inHours} h)';
    } else {
      mainScreenController.formattedSunriseTimeDifference =
          '(In ${mainScreenController.sunriseTimeDifference.inHours} h})';
      mainScreenController.formattedSunsetTimeDifference =
          '(${-mainScreenController.sunsetTimeDifference.inHours} h ago)';
    }

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on),
              Text(
                '${mainScreenController.location}, ${mainScreenController.country}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          centerTitle: true,
          leading: PopupMenuButton<MenuItem>(
            color: Colors.purple.withOpacity(0.1),
            onSelected: (MenuItem item) {
              if (item == MenuItem.quit) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
                    surfaceTintColor: Colors.transparent,
                    content: const Text('Are you sure you want to exit ?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );

              } else if (item == MenuItem.fiveDayWeatherForecast) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FiveDayWeatherForecastScreen(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
              const PopupMenuItem<MenuItem>(
                value: MenuItem.fiveDayWeatherForecast,
                child: Text('5-day Forecasts',),
              ),
              const PopupMenuItem<MenuItem>(
                value: MenuItem.quit,
                child: Text('Quit'),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingScreen()),
                  );
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 10,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            mainScreenController.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              // letterSpacing: -5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              '${mainScreenController.temperature}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 110,
                                letterSpacing: -1,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Feels like ${mainScreenController.feelsLikeTemperature} °C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                // letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        right: 50,
                        child: Image.network(
                          'https://openweathermap.org/img/wn/${mainScreenController.iconCode}@2x.png',
                          fit: BoxFit.contain,
                          width: 125,
                          height: 125,
                          // scale: ,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${mainScreenController.date} | ${mainScreenController.time}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // letterSpacing: -1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.deepPurple.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const BoxedIcon(WeatherIcons.cloudy, size: 45),
                          Text(
                            '${mainScreenController.cloudsDensity} %',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text('Cloudiness'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const BoxedIcon(WeatherIcons.raindrop, size: 45),
                          Text(
                            '${mainScreenController.humidity} %',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text('Humidity'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const BoxedIcon(WeatherIcons.strong_wind, size: 45),
                          Text(
                            '${mainScreenController.windSpeed} km/h',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Text('Wind speed'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 145,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.deepPurple.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const BoxedIcon(WeatherIcons.sunrise, size: 35),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(mainScreenController.sunriseTime),
                                Text(mainScreenController
                                    .formattedSunriseTimeDifference),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.deepPurple.withOpacity(0.3),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const BoxedIcon(WeatherIcons.sunset, size: 35),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(mainScreenController.sunsetTime),
                                Text(mainScreenController
                                    .formattedSunsetTimeDifference),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Other regions',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    )),
                FutureBuilder<List<RegionWeatherModel>>(
                    future: MyUtils.fetchCountryWeatherData(
                        mainScreenController.latitudes,
                        mainScreenController.longitudes),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 80.0,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 80.0,
                          alignment: Alignment.center,
                          child: const Text(
                              'Erreur lors de la récupération des données météorologiques'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 80.0,
                          alignment: Alignment.center,
                          child: const Text(
                              'Aucune donnée météorologique disponible'),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.only(left: 20, top: 10),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 80.0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              padEnds: false,
                              enableInfiniteScroll: true,
                              viewportFraction: 0.7,
                            ),
                            items: snapshot.data!.map((countryWeather) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Stack(
                                    children: [
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.deepPurple
                                                .withOpacity(0.3),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 70, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      countryWeather
                                                          .locationName,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 120,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            countryWeather
                                                                    .weatherDescription[
                                                                        0]
                                                                    .toUpperCase() +
                                                                countryWeather
                                                                    .weatherDescription
                                                                    .substring(
                                                                        1),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Align(
                                                  child: Text(
                                                    '${countryWeather.temperature.round()}°',
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.network(
                                          'https://openweathermap.org/img/wn/${countryWeather.iconWeather}@2x.png',
                                          fit: BoxFit.contain,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
