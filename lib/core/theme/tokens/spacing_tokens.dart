import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class SpacingTokens {
  const SpacingTokens({
    this.xs = 4,
    this.s = 8,
    this.m = 16,
    this.l = 24,
    this.xl = 40,
    this.gutter = 20,
  });

  final double xs;
  final double s;
  final double m;
  final double l;
  final double xl;
  final double gutter; // screen horizontal margin

  static const standard = SpacingTokens();

  SpacingTokens copyWith({
    double? xs,
    double? s,
    double? m,
    double? l,
    double? xl,
    double? gutter,
  }) {
    return SpacingTokens(
      xs: xs ?? this.xs,
      s: s ?? this.s,
      m: m ?? this.m,
      l: l ?? this.l,
      xl: xl ?? this.xl,
      gutter: gutter ?? this.gutter,
    );
  }

  SpacingTokens lerp(SpacingTokens other, double t) => SpacingTokens(
        xs: lerpDouble(xs, other.xs, t)!,
        s: lerpDouble(s, other.s, t)!,
        m: lerpDouble(m, other.m, t)!,
        l: lerpDouble(l, other.l, t)!,
        xl: lerpDouble(xl, other.xl, t)!,
        gutter: lerpDouble(gutter, other.gutter, t)!,
      );
}