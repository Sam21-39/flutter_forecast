import 'package:flutter/material.dart';

@immutable
class SurfaceTokens {
  const SurfaceTokens({
    required this.base,
    required this.raised,
    required this.sunken,
    required this.overlay,
  });

  final Color base;
  final Color raised;
  final Color sunken;
  final Color overlay; // scrim behind sheets

  static const light = SurfaceTokens(
    base: Color(0xFFF7F7F8),
    raised: Color(0xFFFFFFFF),
    sunken: Color(0xFFEEEEF0),
    overlay: Color(0x40000000), // black @ 25%
  );

  static const dark = SurfaceTokens(
    base: Color(0xFF0B0B0D),
    raised: Color(0xFF161618),
    sunken: Color(0xFF26262A),
    overlay: Color(0x66000000), // black @ 40%
  );

  SurfaceTokens copyWith({
    Color? base,
    Color? raised,
    Color? sunken,
    Color? overlay,
  }) {
    return SurfaceTokens(
      base: base ?? this.base,
      raised: raised ?? this.raised,
      sunken: sunken ?? this.sunken,
      overlay: overlay ?? this.overlay,
    );
  }

  SurfaceTokens lerp(SurfaceTokens other, double t) => SurfaceTokens(
        base: Color.lerp(base, other.base, t)!,
        raised: Color.lerp(raised, other.raised, t)!,
        sunken: Color.lerp(sunken, other.sunken, t)!,
        overlay: Color.lerp(overlay, other.overlay, t)!,
      );
}