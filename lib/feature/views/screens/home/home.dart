import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
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

  // weather images

  _wetherImages(bool isDay, int code) {
    switch (code) {
      case 0 || 1:
        return isDay ? SUNLIGHT : MOONLIGHT;
      case 2:
        return isDay ? CLOUDY_MORNING : CLOUDY_NIGHT;
      case 3:
        return OVERCAST;
      case 45 || 48:
        return COLD;
      case 51 || 53 || 55:
        return DRIZZLE;
      case 56 || 57:
        return EXTREME_WEATHER;
      case 61 || 63 || 65 || 80 || 81 || 82:
        return RAINFALL;
      case 66 || 67 || 71 || 73 || 75 || 77 || 85 || 86:
        return SNOWFALL;
      case 95 || 96 || 99:
        return THUNDERSTORM;

      default:
        return DAYNIGHT;
    }
  }

  // ----------------------------------------------------------------
  // time variants
  _timeFrameColors() {
    final time = DateTime.now().toLocal();
    if (time.hour >= 4 && time.hour < 6) {
      return Colors.red.shade200;
    }
    if (time.hour >= 6 && time.hour < 12) {
      return Colors.lightBlue.shade300;
    }
    if (time.hour >= 12 && time.hour < 13) {
      return UIColors.sunlight;
    }
    if (time.hour >= 13 && time.hour < 17) {
      return Colors.deepOrange.shade400;
    }
    if (time.hour >= 17 && time.hour < 18) {
      return const Color.fromARGB(255, 208, 153, 138);
    }
    if (time.hour >= 18 && time.hour < 20) {
      return Colors.brown.shade400;
    }
    if (time.hour >= 20 && time.hour < 22) {
      return Colors.black12;
    }
    if (time.hour >= 22 && time.hour < 24) {
      return Colors.black45;
    }
    if (time.hour >= 0 && time.hour < 4) {
      return Colors.blueGrey;
    }
    return UIColors.overall;
  }

  _timeFrame() {
    final time = DateTime.now().toLocal();
    if (time.hour >= 4 && time.hour < 6) {
      return 'Early Morning';
    }
    if (time.hour >= 6 && time.hour < 12) {
      return 'Morning';
    }
    if (time.hour >= 12 && time.hour < 13) {
      return 'Noon';
    }
    if (time.hour >= 13 && time.hour < 17) {
      return 'Afternoon';
    }
    if (time.hour >= 17 && time.hour < 18) {
      return 'Early Evening';
    }
    if (time.hour >= 18 && time.hour < 20) {
      return 'Evening';
    }
    if (time.hour >= 20 && time.hour < 22) {
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

  //---------------------------------------------

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
                  _wetherImages(weatherModel.current!.isDay == 1,
                      weatherModel.current!.weatherCode!),
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
                    color: UIColors.overall),
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    textAlign: TextAlign.end,
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
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.65),
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
          gradient:
              // Sweep Gradient instead of LinearGradient
              SweepGradient(
            center: const FractionalOffset(
              0.485,
              0.595,
            ),
            colors: [
              _timeFrameColors(),
              Colors.white,
              UIColors.overall,
            ],
          ),
          // LinearGradient(
          //   colors: [
          //     Colors.white,
          //     _timeFrameColors().withOpacity(0.65),
          //     UIColors.overall,
          //   ],
          //   begin: const FractionalOffset(0.4, 0.12),
          //   end: const FractionalOffset(0.7, 0.75),
          // ),
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
        if (!state.isLoading &&
            state.weatherModel.error == null &&
            state.isGraphOrInfo == null) {
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
          duration: const Duration(milliseconds: 1800),
          child: !state.isLoading && state.weatherModel.error == null
              ? LiquidPullToRefresh(
                  color: UIColors.overall,
                  animSpeedFactor: 1.8,
                  springAnimationDurationInMilliseconds: 800,
                  onRefresh: () async {
                    BlocProvider.of<HomeCubit>(context).refresh();
                    _getUserAddress();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
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
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    '7-day Weather Forecast',
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      color: _colors()[1],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: AnimatedToggleSwitch.dual(
                                    animationDuration:
                                        const Duration(milliseconds: 1200),
                                    iconBuilder: (value) {
                                      if (value == 0) {
                                        return Icon(
                                          Icons.show_chart_rounded,
                                          size: 24.sp,
                                          color: Colors.white,
                                        );
                                      }
                                      return Icon(
                                        Icons.info_outline_rounded,
                                        size: 24.sp,
                                        color: Colors.white,
                                      );
                                    },
                                    current: state.isGraphOrInfo != null &&
                                            state.isGraphOrInfo!
                                        ? 1
                                        : 0,
                                    first: 0,
                                    second: 1,
                                    active: true,
                                    animationCurve: Curves.easeInOutCubic,
                                    style: ToggleStyle(
                                      indicatorColor: _timeFrameColors(),
                                      borderColor: UIColors.overall,
                                      backgroundGradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          UIColors.overall,
                                          Colors.white,
                                        ],
                                      ),
                                    ),
                                    onChanged: (val) {
                                      Log.showLog(val.toString());
                                      BlocProvider.of<HomeCubit>(context)
                                          .changeGraphOrInfoState(
                                        val,
                                        state.weatherModel,
                                      );
                                    },
                                    onTap: (props) {
                                      Log.showLog(
                                          props.tapped!.index.toString());
                                      BlocProvider.of<HomeCubit>(context)
                                          .changeGraphOrInfoState(
                                        props.tapped!.index,
                                        state.weatherModel,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
