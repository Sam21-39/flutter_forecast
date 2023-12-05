// To parse this JSON data, do
//
//     final aqiModel = aqiModelFromJson(jsonString);

import 'dart:convert';

AqiModel aqiModelFromJson(String str) => AqiModel.fromJson(json.decode(str));

String aqiModelToJson(AqiModel data) => json.encode(data.toJson());

class AqiModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnits? currentUnits;
  Current? current;
  bool? error;
  String? reason;
  AqiModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
    this.error,
    this.reason,
  });

  factory AqiModel.fromJson(Map<String, dynamic> json) => AqiModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        currentUnits: json["current_units"] == null
            ? null
            : CurrentUnits.fromJson(json["current_units"]),
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
        error: json["error"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_units": currentUnits?.toJson(),
        "current": current?.toJson(),
        "error": error,
        "reason": reason,
      };
}

class Current {
  String? time;
  int? interval;
  double? pm10;
  double? pm25;
  double? carbonMonoxide;
  double? nitrogenDioxide;
  double? sulphurDioxide;
  double? ozone;
  double? dust;
  double? uvIndex;

  Current({
    this.time,
    this.interval,
    this.pm10,
    this.pm25,
    this.carbonMonoxide,
    this.nitrogenDioxide,
    this.sulphurDioxide,
    this.ozone,
    this.dust,
    this.uvIndex,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        time: json["time"],
        interval: json["interval"],
        pm10: json["pm10"]?.toDouble(),
        pm25: json["pm2_5"]?.toDouble(),
        carbonMonoxide: json["carbon_monoxide"],
        nitrogenDioxide: json["nitrogen_dioxide"]?.toDouble(),
        sulphurDioxide: json["sulphur_dioxide"]?.toDouble(),
        ozone: json["ozone"],
        dust: json["dust"],
        uvIndex: json["uv_index"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "pm10": pm10,
        "pm2_5": pm25,
        "carbon_monoxide": carbonMonoxide,
        "nitrogen_dioxide": nitrogenDioxide,
        "sulphur_dioxide": sulphurDioxide,
        "ozone": ozone,
        "dust": dust,
        "uv_index": uvIndex,
      };
}

class CurrentUnits {
  String? time;
  String? interval;
  String? pm10;
  String? pm25;
  String? carbonMonoxide;
  String? nitrogenDioxide;
  String? sulphurDioxide;
  String? ozone;
  String? dust;
  String? uvIndex;

  CurrentUnits({
    this.time,
    this.interval,
    this.pm10,
    this.pm25,
    this.carbonMonoxide,
    this.nitrogenDioxide,
    this.sulphurDioxide,
    this.ozone,
    this.dust,
    this.uvIndex,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
        time: json["time"],
        interval: json["interval"],
        pm10: json["pm10"],
        pm25: json["pm2_5"],
        carbonMonoxide: json["carbon_monoxide"],
        nitrogenDioxide: json["nitrogen_dioxide"],
        sulphurDioxide: json["sulphur_dioxide"],
        ozone: json["ozone"],
        dust: json["dust"],
        uvIndex: json["uv_index"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "pm10": pm10,
        "pm2_5": pm25,
        "carbon_monoxide": carbonMonoxide,
        "nitrogen_dioxide": nitrogenDioxide,
        "sulphur_dioxide": sulphurDioxide,
        "ozone": ozone,
        "dust": dust,
        "uv_index": uvIndex,
      };
}
