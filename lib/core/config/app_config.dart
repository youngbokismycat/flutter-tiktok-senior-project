import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppConfig {
  static FlexSchemeColor schemeLight = FlexSchemeColor.from(
    primary: const Color(0xFF00296B),
    secondary: const Color(0xFFFF7B00),
    brightness: Brightness.light,
  );

  static FlexSchemeColor schemeDark = FlexSchemeColor.from(
    primary: const Color(0xFF6B8BC3),
    secondary: const Color(0xffff7155),
    brightness: Brightness.dark,
  );

  static const FlexScheme scheme = FlexScheme.sakura;
  static const bool useScheme = true;
  static const double appBarElevation = 0;
  static const double appBarOpacity = 1;
  static const bool computeDarkTheme = false;
  static const int toDarkLevel = 30;
  static const bool swapColors = false;
  static const int usedColors = 6;

  static const FlexKeyColors keyColors = FlexKeyColors(
    useKeyColors: false,
    useSecondary: true,
    useTertiary: true,
    keepPrimary: false,
    keepPrimaryContainer: false,
    keepSecondary: false,
    keepSecondaryContainer: false,
    keepTertiary: false,
    keepTertiaryContainer: false,
  );

  static final FlexTones flexTonesLight = FlexTones.material(Brightness.light);
  static final FlexTones flexTonesDark = FlexTones.material(Brightness.dark);

  static TextTheme textTheme = GoogleFonts.juaTextTheme();

  static const FlexSurfaceMode surfaceMode =
      FlexSurfaceMode.highBackgroundLowScaffold;
  static const int blendLevel = 20;
  static const bool useSubThemes = true;

  static const FlexSubThemesData subThemesData = FlexSubThemesData(
    interactionEffects: true,
    defaultRadius: null,
    bottomSheetRadius: 24,
    useTextTheme: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorIsFilled: true,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorBackgroundAlpha: 20,
    chipSchemeColor: SchemeColor.primary,
    elevatedButtonElevation: 1,
    thickBorderWidth: 1.5,
    thinBorderWidth: 1,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,
  );

  static const bool transparentStatusBar = true;
  static const FlexTabBarStyle tabBarForAppBar = FlexTabBarStyle.forAppBar;
  static const bool tooltipsMatchBackground = true;
  static final VisualDensity visualDensity =
      FlexColorScheme.comfortablePlatformDensity;
  static final TargetPlatform platform = defaultTargetPlatform;
}
