import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_forecast/core/utils/codes.dart';
import 'package:flutter_forecast/core/utils/constants.dart';
import 'package:flutter_forecast/core/utils/ui_colors.dart';
import 'package:flutter_forecast/feature/models/weather_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Forecast extends StatefulWidget {
  final WeatherModel weatherModel;
  final Color backColor;
  final double? top, left;
  final int index;
  final double width, height;

  const Forecast({
    super.key,
    required this.weatherModel,
    required this.backColor,
    this.top = 0.0,
    this.left = 0.0,
    required this.index,
    required this.width,
    required this.height,
  });

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2020),
    vsync: this,
  )..forward();
  late final Animation<Offset> _positionAnimation = Tween<Offset>(
    begin: Offset.fromDirection(0.0),
    end: Offset(widget.left!, 0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: Container(
        // height: widget.height,
        width: widget.width,
        margin: EdgeInsets.only(
          left: 16.sp,
          top: 16.sp,
          bottom: 16.sp,
          right: widget.index == 7 ? 16.sp : 0,
        ),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              widget.backColor,
              UIColors.overall,
            ],
            begin: const FractionalOffset(0.4, 0.12),
            end: const FractionalOffset(0.7, 0.75),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2.sp,
              offset: Offset.fromDirection(
                pi / 2,
              ),
              color: Colors.black38,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.square(
              dimension: 80.sp,
              child: SvgPicture.asset(
                _wetherImages(
                  widget.weatherModel.current!.isDay == 1,
                  widget.weatherModel.daily!.weatherCode![widget.index],
                ),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "${WeatherCodes.codes[widget.weatherModel.daily!.weatherCode![widget.index]]}",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: UIColors.overall,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.square(
                  dimension: 50.sp,
                  child: SvgPicture.asset(
                    HOT,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "${widget.weatherModel.daily!.temperature2MMax![widget.index]} ${widget.weatherModel.dailyUnits!.temperature2MMax}",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.weatherModel.daily!.temperature2MMin![widget.index]} ${widget.weatherModel.dailyUnits!.temperature2MMin}",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox.square(
                  dimension: 50.sp,
                  child: SvgPicture.asset(
                    COLD,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Text(
              widget.weatherModel.daily!.time![widget.index]
                  .toIso8601String()
                  .split(
                    'T',
                  )[0],
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
            Column(
              children: [
                Text(
                  'Sunrise - Sunset',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '${widget.weatherModel.daily!.sunrise![widget.index].split('T')[1]} - ${widget.weatherModel.daily!.sunset![widget.index].split('T')[1]}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
}
