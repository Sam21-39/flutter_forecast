// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'tokens/app_tokens.dart';

ThemeData buildTheme(Brightness brightness) {
  final tokens = brightness == Brightness.dark ? AppTokens.dark : AppTokens.light;
  final c = tokens.colors;

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: c.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: c.accent,
      brightness: brightness,
      primary: c.accent,
      onPrimary: c.onAccent,
      surface: c.surface,
    ),
    textTheme: TextTheme(
      displayLarge: tokens.typography.displayTemp.copyWith(color: c.textPrimary),
      headlineMedium: tokens.typography.displayLarge.copyWith(color: c.textPrimary),
      titleLarge: tokens.typography.titleAi.copyWith(color: c.textPrimary),
      titleMedium: tokens.typography.titleMedium.copyWith(color: c.textPrimary),
      bodyMedium: tokens.typography.body.copyWith(color: c.textSecondary),
      labelMedium: tokens.typography.caption.copyWith(color: c.textSecondary),
      labelSmall: tokens.typography.micro.copyWith(color: c.textTertiary),
    ),
    extensions: [tokens],
  );
}