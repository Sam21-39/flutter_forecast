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

  _weatherUI(BuildContext context, WeatherModel weatherModel) {
    return Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            weatherModel.current!.temperature2M.toString(),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            WeatherCodes.codes[weatherModel.current!.weatherCode].toString(),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ],
    );
  }

  _currentWeatherUI(BuildContext context, WeatherModel weatherModel) {
    return SizedBox(
      width: double.maxFinite,
      height: 350.h,
      child: Container(
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: UIColors.sunlight,
          borderRadius: BorderRadius.circular(8),
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
