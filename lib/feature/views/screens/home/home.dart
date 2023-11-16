import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/core/widgets/base_scaffold.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';
import 'package:flutter_forecast/feature/viewModels/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'FlutterForecast',
      colors: _colors(),
      body: BlocProvider(
        create: (context) => HomeCubit()..init(),
        child: _blocLogic(context),
      ),
    );
  }

  // base colors
  _colors() {
    return [
      Colors.white,
      Colors.black87,
    ];
  }

  _timeFrameColors() {
    final DateTime time = DateTime.now().toLocal();
    Log.showLog(
      time.toIso8601String().splitMapJoin(
            'T',
            onMatch: (_) => ' ',
          ),
    );

    if (time.hour >= 0 && time.hour < 4) {
      return [
        Colors.black87,
        Colors.black38,
      ];
    }
    if (time.hour >= 4 && time.hour < 12) {
      return [
        Colors.amber.shade500,
        Colors.amber.shade200,
      ];
    }
    if (time.hour >= 12 && time.hour < 17) {
      return [
        Colors.deepOrange.shade400,
        Colors.deepOrange.shade200,
      ];
    }
    if (time.hour >= 17 && time.hour < 20) {
      return [
        Colors.lightBlueAccent.shade400,
        Colors.lightBlueAccent.shade200,
      ];
    }
    if (time.hour >= 20 && time.hour < 23) {
      return [
        Colors.black87,
        Colors.black38,
      ];
    }
  }

  _currentCard(BuildContext context, WeatherModel weatherModel) {
    return SizedBox(
      width: double.maxFinite,
      height: 350.h,
      child: Container(
        margin: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: _timeFrameColors(),
          ),
        ),
        child: const Column(children: []),
      ),
    );
  }

  _blocLogic(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (!state.isLoading && state.weatherModel.error == null) {
          EasyLoading.showSuccess('Weather fetched successfully');
        }
        if (!state.isLoading && state.weatherModel.error != null) {
          EasyLoading.showError('Weather fecthing failed');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        if (!state.isLoading && state.weatherModel.error != null) {
          return Container(
            padding: EdgeInsets.all(16.sp),
            height: MediaQuery.of(context).size.height * 0.85,
            child: Center(
              child: Text(
                'Valid data not found! Please, check again later!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1200),
          child: !state.isLoading && state.weatherModel.error == null
              ? LiquidPullToRefresh(
                  onRefresh: () async {
                    BlocProvider.of<HomeCubit>(context).refresh();
                  },
                  child: ListView(shrinkWrap: true, children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _currentCard(
                          context,
                          state.weatherModel,
                        ),
                      ],
                    ),
                  ]),
                )
              : Container(),
        );
      },
    );
  }
}
