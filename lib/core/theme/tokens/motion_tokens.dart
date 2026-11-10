import 'package:flutter/material.dart';

@immutable
class MotionTokens {
  const MotionTokens({
    this.fast = const Duration(milliseconds: 150),
    this.standard = const Duration(milliseconds: 280),
    this.slow = const Duration(milliseconds: 600),
    this.idleLoop = const Duration(seconds: 12),
    this.curveStandard = Curves.easeInOut,
    this.curveFast = Curves.easeOut,
    this.curveSlow = Curves.easeInOutSine,
  });

  final Duration fast;
  final Duration standard;
  final Duration slow;
  final Duration idleLoop;
  final Curve curveStandard;
  final Curve curveFast;
  final Curve curveSlow;

  static const standardSet = MotionTokens();

  MotionTokens copyWith({
    Duration? fast,
    Duration? standard,
    Duration? slow,
    Duration? idleLoop,
    Curve? curveStandard,
    Curve? curveFast,
    Curve? curveSlow,
  }) {
    return MotionTokens(
      fast: fast ?? this.fast,
      standard: standard ?? this.standard,
      slow: slow ?? this.slow,
      idleLoop: idleLoop ?? this.idleLoop,
      curveStandard: curveStandard ?? this.curveStandard,
      curveFast: curveFast ?? this.curveFast,
      curveSlow: curveSlow ?? this.curveSlow,
    );
  }

  /// Durations and curves don't interpolate meaningfully; switch at the midpoint.
  MotionTokens lerp(MotionTokens other, double t) => t < 0.5 ? this : other;
}