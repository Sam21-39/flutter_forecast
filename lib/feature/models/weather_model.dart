// // To parse this JSON data, do
// //
// //     final weatherModel = weatherModelFromJson(jsonString);

// import 'dart:convert';

// WeatherModel weatherModelFromJson(String str) =>
//     WeatherModel.fromJson(json.decode(str));

// String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  bool? error;
  String? reason;
  CurrentUnits? currentUnits;
  Current? current;
  // HourlyUnits? hourlyUnits;
  // Hourly? hourly;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.error,
    this.reason,
    this.currentUnits,
    this.current,
    // this.hourlyUnits,
    // this.hourly,
    this.dailyUnits,
    this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        error: json["error"],
        reason: json["reason"],
        currentUnits: json["current_units"] == null
            ? null
            : CurrentUnits.fromJson(json["current_units"]),
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
        // hourlyUnits: json["hourly_units"] == null
        //     ? null
        //     : HourlyUnits.fromJson(json["hourly_units"]),
        // hourly: json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]),
        dailyUnits: json["daily_units"] == null
            ? null
            : DailyUnits.fromJson(json["daily_units"]),
        daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "error": error,
        "reason": reason,
        "current_units": currentUnits?.toJson(),
        "current": current?.toJson(),
        // "hourly_units": hourlyUnits?.toJson(),
        // "hourly": hourly?.toJson(),
        "daily_units": dailyUnits?.toJson(),
        "daily": daily?.toJson(),
      };
}

class Current {
  String? time;
  int? interval;
  double? temperature2M;
  int? isDay;
  double? precipitation;
  double? rain;
  int? weatherCode;
  double? windSpeed10M;
  int? humidity;
  int? windDirection10M;

  Current({
    this.time,
    this.interval,
    this.temperature2M,
    this.isDay,
    this.precipitation,
    this.rain,
    this.weatherCode,
    this.humidity,
    this.windSpeed10M,
    this.windDirection10M,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"]?.toDouble(),
        isDay: json["is_day"],
        precipitation: json["precipitation"],
        rain: json["rain"],
        weatherCode: json["weather_code"],
        windSpeed10M: json["wind_speed_10m"]?.toDouble(),
        windDirection10M: json["wind_direction_10m"],
        humidity: json["relative_humidity_2m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
        "is_day": isDay,
        "precipitation": precipitation,
        "rain": rain,
        "weather_code": weatherCode,
        "wind_speed_10m": windSpeed10M,
        "wind_direction_10m": windDirection10M,
        "relative_humidity_2m": humidity,
      };
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2M;
  String? isDay;
  String? precipitation;
  String? rain;
  String? humidity;
  String? weatherCode;
  String? windSpeed10M;
  String? windDirection10M;

  CurrentUnits({
    this.time,
    this.interval,
    this.temperature2M,
    this.isDay,
    this.precipitation,
    this.rain,
    this.humidity,
    this.weatherCode,
    this.windSpeed10M,
    this.windDirection10M,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"],
        isDay: json["is_day"],
        precipitation: json["precipitation"],
        rain: json["rain"],
        weatherCode: json["weather_code"],
        windSpeed10M: json["wind_speed_10m"],
        windDirection10M: json["wind_direction_10m"],
        humidity: json["relative_humidity_2m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
        "is_day": isDay,
        "precipitation": precipitation,
        "rain": rain,
        "weather_code": weatherCode,
        "wind_speed_10m": windSpeed10M,
        "wind_direction_10m": windDirection10M,
        "relative_humidity_2m": humidity,
      };
}

class Daily {
  List<DateTime>? time;
  List<int>? weatherCode;
  List<double>? temperature2MMax;
  List<double>? temperature2MMin;
  List<String>? sunrise;
  List<String>? sunset;
  List<double>? uvIndexMax;

  Daily({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
    this.uvIndexMax,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: json["time"] == null
            ? []
            : List<DateTime>.from(json["time"]!.map((x) => DateTime.parse(x))),
        weatherCode: json["weather_code"] == null
            ? []
            : List<int>.from(json["weather_code"]!.map((x) => x)),
        temperature2MMax: json["temperature_2m_max"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_max"]!.map((x) => x?.toDouble())),
        temperature2MMin: json["temperature_2m_min"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_min"]!.map((x) => x?.toDouble())),
        sunrise: json["sunrise"] == null
            ? []
            : List<String>.from(json["sunrise"]!.map((x) => x)),
        sunset: json["sunset"] == null
            ? []
            : List<String>.from(json["sunset"]!.map((x) => x)),
        uvIndexMax: json["uv_index_max"] == null
            ? []
            : List<double>.from(
                json["uv_index_max"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null
            ? []
            : List<dynamic>.from(time!.map((x) =>
                "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "weather_code": weatherCode == null
            ? []
            : List<dynamic>.from(weatherCode!.map((x) => x)),
        "temperature_2m_max": temperature2MMax == null
            ? []
            : List<dynamic>.from(temperature2MMax!.map((x) => x)),
        "temperature_2m_min": temperature2MMin == null
            ? []
            : List<dynamic>.from(temperature2MMin!.map((x) => x)),
        "sunrise":
            sunrise == null ? [] : List<dynamic>.from(sunrise!.map((x) => x)),
        "sunset":
            sunset == null ? [] : List<dynamic>.from(sunset!.map((x) => x)),
        "uv_index_max": uvIndexMax == null
            ? []
            : List<dynamic>.from(uvIndexMax!.map((x) => x)),
      };
}

class DailyUnits {
  String? time;
  String? weatherCode;
  String? temperature2MMax;
  String? temperature2MMin;
  String? sunrise;
  String? sunset;
  String? uvIndexMax;

  DailyUnits({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
    this.uvIndexMax,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json["time"],
        weatherCode: json["weather_code"],
        temperature2MMax: json["temperature_2m_max"],
        temperature2MMin: json["temperature_2m_min"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        uvIndexMax: json["uv_index_max"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "weather_code": weatherCode,
        "temperature_2m_max": temperature2MMax,
        "temperature_2m_min": temperature2MMin,
        "sunrise": sunrise,
        "sunset": sunset,
        "uv_index_max": uvIndexMax,
      };
}

// class Hourly {
//   List<String>? time;
//   List<double>? temperature2M;
//   List<int>? weatherCode;

//   Hourly({
//     this.time,
//     this.temperature2M,
//     this.weatherCode,
//   });

//   factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
//         time: json["time"] == null
//             ? []
//             : List<String>.from(json["time"]!.map((x) => x)),
//         temperature2M: json["temperature_2m"] == null
//             ? []
//             : List<double>.from(
//                 json["temperature_2m"]!.map((x) => x?.toDouble())),
//         weatherCode: json["weather_code"] == null
//             ? []
//             : List<int>.from(json["weather_code"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "time": time == null ? [] : List<dynamic>.from(time!.map((x) => x)),
//         "temperature_2m": temperature2M == null
//             ? []
//             : List<dynamic>.from(temperature2M!.map((x) => x)),
//         "weather_code": weatherCode == null
//             ? []
//             : List<dynamic>.from(weatherCode!.map((x) => x)),
//       };
// }

// class HourlyUnits {
//   String? time;
//   String? temperature2M;
//   String? weatherCode;

//   HourlyUnits({
//     this.time,
//     this.temperature2M,
//     this.weatherCode,
//   });

//   factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
//         time: json["time"],
//         temperature2M: json["temperature_2m"],
//         weatherCode: json["weather_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "time": time,
//         "temperature_2m": temperature2M,
//         "weather_code": weatherCode,
//       };
// }
