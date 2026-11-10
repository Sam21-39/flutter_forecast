import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class RadiusTokens {
  const RadiusTokens({
    this.chip = 999,
    this.card = 20,
    this.button = 14,
    this.input = 12,
    this.widget = 22,
    this.sheet = 28,
  });

  final double chip;
  final double card;
  final double button;
  final double input;
  final double widget;
  final double sheet;

  static const standard = RadiusTokens();

  RadiusTokens copyWith({
    double? chip,
    double? card,
    double? button,
    double? input,
    double? widget,
    double? sheet,
  }) {
    return RadiusTokens(
      chip: chip ?? this.chip,
      card: card ?? this.card,
      button: button ?? this.button,
      input: input ?? this.input,
      widget: widget ?? this.widget,
      sheet: sheet ?? this.sheet,
    );
  }

  RadiusTokens lerp(RadiusTokens other, double t) => RadiusTokens(
        chip: lerpDouble(chip, other.chip, t)!,
        card: lerpDouble(card, other.card, t)!,
        button: lerpDouble(button, other.button, t)!,
        input: lerpDouble(input, other.input, t)!,
        widget: lerpDouble(widget, other.widget, t)!,
        sheet: lerpDouble(sheet, other.sheet, t)!,
      );
}