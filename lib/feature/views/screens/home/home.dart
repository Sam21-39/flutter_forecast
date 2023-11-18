import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_forecast/core/services/apis/apis.dart';
import 'package:flutter_forecast/core/utils/codes.dart';
import 'package:flutter_forecast/core/utils/constants.dart';
import 'package:flutter_forecast/core/utils/log.dart';
import 'package:flutter_forecast/core/utils/ui_colors.dart';
import 'package:flutter_forecast/core/widgets/base_scaffold.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';
import 'package:flutter_forecast/feature/viewModels/cubit/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final location = TextEditingController(text: 'FlutterForecast');

  @override
  void initState() {
    _getUserAddress();
    super.initState();
  }

  _getUserAddress() async {
    final Position position = await Apis.determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Log.showLog(placemarks.toString());
    location.text = placemarks.first.locality.toString();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: location,
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

  _timeFrame() {
    final time = DateTime.now().toLocal();
    if (time.hour >= 4 && time.hour < 12) {
      return 'Morning';
    }
    if (time.hour >= 12 && time.hour < 13) {
      return 'Noon';
    }
    if (time.hour >= 13 && time.hour < 16) {
      return 'Afternoon';
    }
    if (time.hour >= 16 && time.hour < 18) {
      return 'Early Evening';
    }
    if (time.hour >= 18 && time.hour < 22) {
      return 'Night';
    }
    if (time.hour >= 22 && time.hour < 24) {
      return 'Midnight';
    }
    if (time.hour >= 0 && time.hour < 4) {
      return 'Post Midnight';
    }
    return '';
  }

  _wweatherDetailsUI(BuildContext context, WeatherModel weatherModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox.square(
                dimension: 60.sp,
                child: SvgPicture.asset(
                  WIND,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "${weatherModel.current!.windSpeed10M} ${weatherModel.currentUnits!.windSpeed10M}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: UIColors.overall,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox.square(
                dimension: 60.sp,
                child: SvgPicture.asset(
                  WIND_DIRECTION,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "${weatherModel.current!.windDirection10M} ${weatherModel.currentUnits!.windDirection10M}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: UIColors.overall,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox.square(
                dimension: 60.sp,
                child: SvgPicture.asset(
                  HUMIDITY,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "${weatherModel.current!.humidity} ${weatherModel.currentUnits!.humidity}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: UIColors.overall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _currentWeatherDetailsUI(BuildContext context, WeatherModel weatherModel) {
    return SizedBox(
      width: double.maxFinite,
      // height: 350.h,
      child: Container(
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            )
          ],
        ),
        child: Column(
          children: [
            _wweatherDetailsUI(context, weatherModel),
          ],
        ),
      ),
    );
  }

  _weatherUI(BuildContext context, WeatherModel weatherModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox.square(
                dimension: 200.sp,
                child: SvgPicture.asset(
                  SUNLIGHT,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "${WeatherCodes.codes[weatherModel.current!.weatherCode]}",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: UIColors.overall,
                ),
              ),
              Text(
                _timeFrame(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: UIColors.overall,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${weatherModel.current!.temperature2M} ${weatherModel.currentUnits!.temperature2M}",
                style: TextStyle(
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              // if (weatherModel.current!.rain! > 0.0)
              Column(
                children: [
                  SizedBox.square(
                    dimension: 100.sp,
                    child: SvgPicture.asset(
                      RAIN,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "${weatherModel.current!.rain} ${weatherModel.currentUnits!.rain}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Last updated on \n${weatherModel.current!.time!.splitMapJoin('T', onMatch: (_) => ' ')}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _currentWeatherUI(BuildContext context, WeatherModel weatherModel) {
    return SizedBox(
      width: double.maxFinite,
      // height: 350.h,
      child: Container(
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              UIColors.overall,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            )
          ],
        ),
        child: Column(
          children: [
            _weatherUI(context, weatherModel),
          ],
        ),
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
                  animSpeedFactor: 1.8,
                  springAnimationDurationInMilliseconds: 800,
                  onRefresh: () async {
                    BlocProvider.of<HomeCubit>(context).refresh();
                  },
                  child: ListView(shrinkWrap: true, children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _currentWeatherUI(
                          context,
                          state.weatherModel,
                        ),
                        _currentWeatherDetailsUI(
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
