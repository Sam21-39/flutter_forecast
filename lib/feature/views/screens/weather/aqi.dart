import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_forecast/feature/models/aqi_model.dart';
import 'package:flutter_forecast/feature/views/widgets/loading_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AQI extends StatefulWidget {
  final AqiModel aqiModel;
  final Color backColor;
  final int index;
  final double width, height;

  const AQI({
    super.key,
    required this.aqiModel,
    required this.backColor,
    required this.index,
    required this.width,
    required this.height,
  });

  @override
  State<AQI> createState() => _ForecastState();
}

class _ForecastState extends State<AQI> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 4200),
    vsync: this,
  )..forward();
  late final Animation<Offset> _positionAnimation = Tween<Offset>(
    begin: const Offset(0, 2),
    end: const Offset(0, 0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: Container(
        // height: height,
        width: widget.width,
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          // gradient: LinearGradient(
          //   colors: [
          //     // Colors.white,
          //     UIColors.overall,
          //     widget.backColor,
          //   ],
          //   begin: const FractionalOffset(0.1, 0.25),
          //   end: const FractionalOffset(0.85, 0.85),
          // ),
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
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.sp,
          crossAxisSpacing: 8.sp,
          children: [
            LoadingText(
              descText: 'PM\u2081\u2080',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.pm10.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.pm10!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'PM\u2082\u2085',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.pm25.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.pm25!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'CO',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.carbonMonoxide.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.carbonMonoxide!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'SO\u2082',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.sulphurDioxide.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.sulphurDioxide!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'NO\u2082',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.nitrogenDioxide.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.nitrogenDioxide!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'O\u2083',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.ozone.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.ozone!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'Dust',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.dust.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.dust!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            LoadingText(
              descText: 'UV Index',
              valText: widget.aqiModel.current != null
                  ? widget.aqiModel.current!.uvIndex.toString()
                  : "",
              unitText: widget.aqiModel.currentUnits != null
                  ? widget.aqiModel.currentUnits!.uvIndex!
                  : "",
              isTextLoading: widget.aqiModel.current == null,
            ),
            // Text(
            //   'PM\u2081\u2080 : ${widget.aqiModel.current != null ? widget.aqiModel.current!.pm10 : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Text(
            //   'PM\u2082\u2085 : ${widget.aqiModel.current != null ? widget.aqiModel.current!.pm25 : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Text(
            //   'CO : ${widget.aqiModel.current != null ? widget.aqiModel.current!.carbonMonoxide : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Text(
            //   'NO\u2082 : ${widget.aqiModel.current != null ? widget.aqiModel.current!.nitrogenDioxide : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Text(
            //   'SO\u2082 : ${widget.aqiModel.current != null ? widget.aqiModel.current!.sulphurDioxide : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            // Text(
            //   'O\u2083 : ${widget.aqiModel.current != null ? widget.aqiModel.current!.ozone : ''}',
            //   style: TextStyle(
            //     fontSize: 20.sp,
            //     color: UIColors.sunlight,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
