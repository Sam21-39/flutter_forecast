import 'package:flutter/material.dart';
import 'color_tokens.dart';
import 'typography_tokens.dart';
import 'spacing_tokens.dart';
import 'radius_tokens.dart';
import 'motion_tokens.dart';
import 'glass_tokens.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.motion,
    required this.glass,
  });

  final ColorTokens colors;
  final TypographyTokens typography;
  final SpacingTokens spacing;
  final RadiusTokens radius;
  final MotionTokens motion;
  final GlassTokens glass;

  static const light = AppTokens(
    colors: ColorTokens.light,
    typography: TypographyTokens.standard,
    spacing: SpacingTokens.standard,
    radius: RadiusTokens.standard,
    motion: MotionTokens.standardSet,
    glass: GlassTokens.light,
  );

  static const dark = AppTokens(
    colors: ColorTokens.dark,
    typography: TypographyTokens.standard,
    spacing: SpacingTokens.standard,
    radius: RadiusTokens.standard,
    motion: MotionTokens.standardSet,
    glass: GlassTokens.dark,
  );

  /// Read from any widget: `context.tokens.colors.accent`
  static AppTokens of(BuildContext context) =>
      Theme.of(context).extension<AppTokens>()!;

  @override
  AppTokens copyWith({
    ColorTokens? colors,
    TypographyTokens? typography,
    SpacingTokens? spacing,
    RadiusTokens? radius,
    MotionTokens? motion,
    GlassTokens? glass,
  }) {
    return AppTokens(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      motion: motion ?? this.motion,
      glass: glass ?? this.glass,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      colors: colors.lerp(other.colors, t),
      typography: typography.lerp(other.typography, t),
      spacing: spacing.lerp(other.spacing, t),
      radius: radius.lerp(other.radius, t),
      motion: motion.lerp(other.motion, t),
      glass: glass.lerp(other.glass, t),
    );
  }
}