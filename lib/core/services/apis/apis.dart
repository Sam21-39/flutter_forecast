import 'dart:convert';

import 'package:flutter_forecast/core/utils/constants.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';
import 'package:http/http.dart' as htp;
import 'package:geolocator/geolocator.dart';

class Apis {
  static Future<WeatherModel> getWeather() async {
    try {
      final http = htp.Client();
      final pos = await _determinePosition();
      final url = Uri.parse(
        "$BASE_URL?latitude=${pos.latitude}&longitude=${pos.longitude}$URL_FIXED_PARAMS",
      );

      final res = await http.get(url);
      Log.showLog(res.body);
      return WeatherModel.fromJson(
        json.decode(res.body),
      );
    } catch (e) {
      Log.showLog(e.toString());
      return WeatherModel(error: true, reason: e.toString());
    }
  }

  static Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
