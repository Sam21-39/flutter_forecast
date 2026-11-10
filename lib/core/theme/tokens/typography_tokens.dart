import 'package:flutter/material.dart';

@immutable
class TypographyTokens {
  const TypographyTokens({
    required this.displayTemp,
    required this.displayLarge,
    required this.titleAi,
    required this.titleMedium,
    required this.body,
    required this.caption,
    required this.micro,
  });

  final TextStyle displayTemp;
  final TextStyle displayLarge;
  final TextStyle titleAi;
  final TextStyle titleMedium;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle micro;

  static const _tabular = [FontFeature.tabularFigures()];

  static const standard = TypographyTokens(
    displayTemp: TextStyle(
      fontSize: 120, height: 1.0, fontWeight: FontWeight.w200,
      letterSpacing: -4, fontFeatures: _tabular,
    ),
    displayLarge: TextStyle(
      fontSize: 40, height: 1.1, fontWeight: FontWeight.w300,
      letterSpacing: -0.4,
    ),
    titleAi: TextStyle(
      fontSize: 22, height: 30 / 22, fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontSize: 17, height: 22 / 17, fontWeight: FontWeight.w600,
    ),
    body: TextStyle(
      fontSize: 15, height: 22 / 15, fontWeight: FontWeight.w400,
    ),
    caption: TextStyle(
      fontSize: 13, height: 18 / 13, fontWeight: FontWeight.w500,
    ),
    micro: TextStyle(
      fontSize: 11, height: 14 / 11, fontWeight: FontWeight.w500,
      letterSpacing: 0.2, fontFeatures: _tabular,
    ),
  );

  TypographyTokens copyWith({
    TextStyle? displayTemp,
    TextStyle? displayLarge,
    TextStyle? titleAi,
    TextStyle? titleMedium,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? micro,
  }) {
    return TypographyTokens(
      displayTemp: displayTemp ?? this.displayTemp,
      displayLarge: displayLarge ?? this.displayLarge,
      titleAi: titleAi ?? this.titleAi,
      titleMedium: titleMedium ?? this.titleMedium,
      body: body ?? this.body,
      caption: caption ?? this.caption,
      micro: micro ?? this.micro,
    );
  }

  TypographyTokens lerp(TypographyTokens other, double t) {
    return TypographyTokens(
      displayTemp: TextStyle.lerp(displayTemp, other.displayTemp, t)!,
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      titleAi: TextStyle.lerp(titleAi, other.titleAi, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      micro: TextStyle.lerp(micro, other.micro, t)!,
    );
  }
}