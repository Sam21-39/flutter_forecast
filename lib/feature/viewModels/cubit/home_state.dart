part of 'home_cubit.dart';

final class HomeState {
  final WeatherModel weatherModel;
  final String errorMessage;
  final bool isLoading;
  final bool isForecast;
  final AqiModel? aqiModel;

  HomeState({
    required this.weatherModel,
    required this.errorMessage,
    required this.isLoading,
    required this.isForecast,
    this.aqiModel,
  });
}
