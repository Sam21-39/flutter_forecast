import 'package:flutter/material.dart';
import 'package:flutter_forecast/core/utils/ui_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingText extends StatelessWidget {
  final String descText;
  final String valText;
  final String unitText;
  final bool isTextLoading;
  const LoadingText(
      {super.key,
      required this.descText,
      required this.valText,
      required this.unitText,
      required this.isTextLoading});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$descText :",
          style: TextStyle(
            fontSize: 20.sp,
            color: UIColors.light,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        isTextLoading
            ? SizedBox(
                height: 50.sp,
                width: 100.sp,
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballTrianglePathColored,

                  /// Required, The loading type of the widget
                  colors: [
                    UIColors.sunlight,
                    UIColors.light,
                    Colors.indigo,
                  ],

                  /// Optional, The color collections
                  strokeWidth: 1,
                ),
              )
            : Text(
                " $valText $unitText",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: UIColors.overall,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ],
    );
  }
}
