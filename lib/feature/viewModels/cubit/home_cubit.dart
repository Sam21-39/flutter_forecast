import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_forecast/core/services/apis/apis.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/feature/models/aqi_model.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            weatherModel: WeatherModel(),
            errorMessage: '',
            isLoading: true,
            isForecast: true,
          ),
        );

  init() async {
    try {
      final res = await Apis.getWeather();
      if (res.error ?? false) {
        emit(
          HomeState(
            weatherModel: res,
            errorMessage: res.reason!,
            isLoading: false,
            isForecast: true,
          ),
        );
      }
      emit(
        HomeState(
          weatherModel: res,
          errorMessage: '',
          isLoading: false,
          isForecast: true,
        ),
      );
    } catch (e) {
      Log.showLog(e.toString());
      emit(
        HomeState(
          weatherModel: WeatherModel(error: true, reason: e.toString()),
          errorMessage: e.toString(),
          isLoading: false,
          isForecast: true,
        ),
      );
    }
  }

  refresh() async {
    emit(
      HomeState(
          weatherModel: WeatherModel(),
          errorMessage: '',
          isLoading: true,
          isForecast: true),
    );
    try {
      final res = await Apis.getWeather();
      if (res.error ?? false) {
        emit(
          HomeState(
            weatherModel: res,
            errorMessage: res.reason!,
            isLoading: false,
            isForecast: true,
          ),
        );
      }
      emit(
        HomeState(
          weatherModel: res,
          errorMessage: '',
          isLoading: false,
          isForecast: true,
        ),
      );
    } catch (e) {
      Log.showLog(e.toString());
      emit(
        HomeState(
          weatherModel: WeatherModel(error: true, reason: e.toString()),
          errorMessage: e.toString(),
          isLoading: false,
          isForecast: true,
        ),
      );
    }
  }

  toggleAQI(bool isForecast, WeatherModel wm) async {
    emit(
      HomeState(
        weatherModel: wm,
        errorMessage: '',
        isLoading: false,
        isForecast: isForecast,
        aqiModel: AqiModel(),
      ),
    );
    try {
      if (isForecast) {
        emit(
          HomeState(
            weatherModel: wm,
            errorMessage: '',
            isLoading: false,
            isForecast: isForecast,
            aqiModel: AqiModel(),
          ),
        );
      } else {
        final res = await Apis.getAQI();
        if (res.error ?? false) {
          emit(
            HomeState(
              weatherModel: wm,
              errorMessage: res.reason!,
              isLoading: false,
              isForecast: isForecast,
              aqiModel: res,
            ),
          );
        }
        emit(
          HomeState(
            weatherModel: wm,
            errorMessage: '',
            isLoading: false,
            isForecast: isForecast,
            aqiModel: res,
          ),
        );
      }
    } catch (e) {
      Log.showLog(e.toString());
      emit(
        HomeState(
          weatherModel: wm,
          errorMessage: e.toString(),
          isLoading: false,
          isForecast: isForecast,
          aqiModel: AqiModel(error: true, reason: e.toString()),
        ),
      );
    }
  }
}
