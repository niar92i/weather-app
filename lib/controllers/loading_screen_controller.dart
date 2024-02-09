import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import '../services/weather_service.dart';
import '../utils/location.dart';

class LoadingScreenController {
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
}