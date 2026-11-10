import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class GlassTokens {
  const GlassTokens({
    required this.fill,
    required this.stroke,
    required this.shadow,
    required this.blurSigma,
    required this.fallbackFill,
  });

  final Color fill;
  final Color stroke;
  final List<BoxShadow> shadow;
  final double blurSigma;
  final Color fallbackFill; // used when blur is disabled

  static const light = GlassTokens(
    fill: Color(0x8CFFFFFF),
    stroke: Color(0x99FFFFFF),
    shadow: [
      BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, 8)),
    ],
    blurSigma: 24,
    fallbackFill: Color(0xD9FFFFFF),
  );

  static const dark = GlassTokens(
    fill: Color(0x14FFFFFF),
    stroke: Color(0x1FFFFFFF),
    shadow: [
      BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 8)),
    ],
    blurSigma: 24,
    fallbackFill: Color(0xE6161618),
  );

  GlassTokens copyWith({
    Color? fill,
    Color? stroke,
    List<BoxShadow>? shadow,
    double? blurSigma,
    Color? fallbackFill,
  }) {
    return GlassTokens(
      fill: fill ?? this.fill,
      stroke: stroke ?? this.stroke,
      shadow: shadow ?? this.shadow,
      blurSigma: blurSigma ?? this.blurSigma,
      fallbackFill: fallbackFill ?? this.fallbackFill,
    );
  }

  GlassTokens lerp(GlassTokens other, double t) => GlassTokens(
        fill: Color.lerp(fill, other.fill, t)!,
        stroke: Color.lerp(stroke, other.stroke, t)!,
        shadow: BoxShadow.lerpList(shadow, other.shadow, t) ?? shadow,
        blurSigma: lerpDouble(blurSigma, other.blurSigma, t)!,
        fallbackFill: Color.lerp(fallbackFill, other.fallbackFill, t)!,
      );
}