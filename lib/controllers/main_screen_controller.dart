import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreenController {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  late int temperature;
  late int humidity;
  late int feelsLikeTemperature;
  late int cloudsDensity;
  late String location;
  late String description;
  late String iconCode;
  late String country;
  late int windSpeed;
  late int sunsetUnix;
  late int sunriseUnix;

  late int countryTemperature;
  late String countryWeatherDescription;
  late String countryIconLink;

  String date = DateFormat("EEE, dd MMMM yyyy").format(DateTime.now());
  String time = DateFormat("HH:mm a").format(DateTime.now());

  List<String> latitudes = [
    '-18.9100122',
    '-18.1553985',
    '-12.2779134',
    '-15.7181492',
    '-21.456444',
    '-23.354173'
  ];
  List<String> longitudes = [
    '47.5255809',
    '49.4098352',
    '49.2913394',
    '46.3172577',
    '47.085149',
    '43.66966'
  ];

  late var sunriseTime = DateFormat("HH:mm a").format(DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000));
  late var sunsetTime = DateFormat("HH:mm a").format(DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000));

  late Duration sunriseTimeDifference = DateTime.fromMillisecondsSinceEpoch(sunriseUnix * 1000).difference(DateTime.now());
  late Duration sunsetTimeDifference = DateTime.fromMillisecondsSinceEpoch(sunsetUnix * 1000).difference(DateTime.now());

  late String formattedSunriseTimeDifference;
  late String formattedSunsetTimeDifference;
}