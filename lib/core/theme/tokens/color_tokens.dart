import 'package:flutter/material.dart';

@immutable
class ColorTokens {
  const ColorTokens({
    required this.background,
    required this.surface,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.neutral,
  });

  final Color background;
  final Color surface;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color onAccent;
  final Color success;
  final Color warning;
  final Color danger;
  final Color neutral;

  static const light = ColorTokens(
    background: Color(0xFFF7F7F8),
    surface: Color(0xFFEEEEF0),
    divider: Color(0xFFDCDCE0),
    textPrimary: Color(0xFF14141A),
    textSecondary: Color(0xFF5A5A63),
    textTertiary: Color(0xFF9A9AA3),
    accent: Color(0xFF3B6CF6),
    onAccent: Color(0xFFFFFFFF),
    success: Color(0xFF2E9D62),
    warning: Color(0xFFC98A12),
    danger: Color(0xFFD6453D),
    neutral: Color(0xFF8A8A93),
  );

  static const dark = ColorTokens(
    background: Color(0xFF0B0B0D),
    surface: Color(0xFF161618),
    divider: Color(0xFF26262A),
    textPrimary: Color(0xFFF5F5F7),
    textSecondary: Color(0xFFA4A4AE),
    textTertiary: Color(0xFF6E6E78),
    accent: Color(0xFF7CA2FF),
    onAccent: Color(0xFF0B0B0D),
    success: Color(0xFF5ED39A),
    warning: Color(0xFFF2B84B),
    danger: Color(0xFFFF7A72),
    neutral: Color(0xFF8A8A93),
  );

  ColorTokens copyWith({
    Color? background,
    Color? surface,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? warning,
    Color? danger,
    Color? neutral,
  }) {
    return ColorTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      neutral: neutral ?? this.neutral,
    );
  }

  ColorTokens lerp(ColorTokens other, double t) {
    return ColorTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
    );
  }
}