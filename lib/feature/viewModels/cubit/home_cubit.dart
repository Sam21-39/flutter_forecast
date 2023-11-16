import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_forecast/core/services/apis/apis.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            weatherModel: WeatherModel(),
            errorMessage: '',
            isLoading: true,
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
          ),
        );
      }
      emit(
        HomeState(
          weatherModel: res,
          errorMessage: '',
          isLoading: false,
        ),
      );
    } catch (e) {
      Log.showLog(e.toString());
      emit(
        HomeState(
          weatherModel: WeatherModel(error: true, reason: e.toString()),
          errorMessage: e.toString(),
          isLoading: false,
        ),
      );
    }
  }
}
