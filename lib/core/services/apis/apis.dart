import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_forecast/core/utils/constants.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/feature/models/aqi_model.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';
import 'package:http/http.dart' as htp;
import 'package:geolocator/geolocator.dart';

class Apis {
  static Future<WeatherModel> getWeather() async {
    try {
      final pos = await Apis.determinePosition();
      final url = Uri.parse(
        "$BASE_URL?latitude=${pos.latitude}&longitude=${pos.longitude}$URL_FIXED_PARAMS",
      );
      final res = await compute(apiIsolate, url);
      Log.showLog(res.body);
      return WeatherModel.fromJson(
        json.decode(res.body),
      );
    } catch (e) {
      Log.showLog(e.toString());
      return WeatherModel(error: true, reason: e.toString());
    }
  }

  static Future<AqiModel> getAQI() async {
    try {
      final pos = await Apis.determinePosition();
      final url = Uri.parse(
        "$AQI_BASE_URL?latitude=${pos.latitude}&longitude=${pos.longitude}$AQI_URL_FIXED_PARAMS",
      );
      final res = await compute(apiIsolate, url);
      Log.showLog(res.body);
      return AqiModel.fromJson(
        json.decode(res.body),
      );
    } catch (e) {
      Log.showLog(e.toString());
      return AqiModel(error: true, reason: e.toString());
    }
  }

  static Future<Position> determinePosition() async {
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

apiIsolate(Uri url) async {
  final http = htp.Client();

  return await http.get(url);
}
