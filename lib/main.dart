import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/config/app_config.dart';
import 'package:flutter_senior_project/core/router/router.dart';
import 'package:flutter_senior_project/core/theme/brand_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  ThemeMode themeMode = ThemeMode.system;

  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Hot Reload Playground',
      theme: FlexThemeData.light(
        useMaterial3: useMaterial3,
        colors: AppConfig.useScheme ? null : AppConfig.schemeLight,
        scheme: AppConfig.scheme,
        swapColors: AppConfig.swapColors,
        usedColors: AppConfig.usedColors,
        lightIsWhite: false,
        appBarStyle: null,
        appBarElevation: AppConfig.appBarElevation,
        appBarOpacity: AppConfig.appBarOpacity,
        transparentStatusBar: AppConfig.transparentStatusBar,
        tabBarStyle: AppConfig.tabBarForAppBar,
        surfaceMode: AppConfig.surfaceMode,
        blendLevel: AppConfig.blendLevel,
        tooltipsMatchBackground: AppConfig.tooltipsMatchBackground,
        textTheme: AppConfig.textTheme,
        primaryTextTheme: AppConfig.textTheme,
        keyColors: AppConfig.keyColors,
        tones: AppConfig.flexTonesLight,
        subThemesData: AppConfig.useSubThemes ? AppConfig.subThemesData : null,
        visualDensity: AppConfig.visualDensity,
        platform: AppConfig.platform,
        extensions: <ThemeExtension<dynamic>>{
          lightBrandTheme,
        },
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: useMaterial3,
        colors: (AppConfig.useScheme && AppConfig.computeDarkTheme)
            ? FlexColor.schemes[AppConfig.scheme]!.light
                .toDark(AppConfig.toDarkLevel)
            : AppConfig.useScheme
                ? null
                : AppConfig.computeDarkTheme
                    ? AppConfig.schemeLight.toDark(AppConfig.toDarkLevel, true)
                    : AppConfig.schemeDark,
        scheme: AppConfig.scheme,
        swapColors: AppConfig.swapColors,
        usedColors: AppConfig.usedColors,
        darkIsTrueBlack: false,
        appBarStyle: null,
        appBarElevation: AppConfig.appBarElevation,
        appBarOpacity: AppConfig.appBarOpacity,
        transparentStatusBar: AppConfig.transparentStatusBar,
        tabBarStyle: AppConfig.tabBarForAppBar,
        surfaceMode: AppConfig.surfaceMode,
        blendLevel: AppConfig.blendLevel,
        tooltipsMatchBackground: AppConfig.tooltipsMatchBackground,
        textTheme: AppConfig.textTheme,
        primaryTextTheme: AppConfig.textTheme,
        keyColors: AppConfig.keyColors,
        tones: AppConfig.flexTonesDark,
        subThemesData: AppConfig.useSubThemes ? AppConfig.subThemesData : null,
        visualDensity: AppConfig.visualDensity,
        platform: AppConfig.platform,
        extensions: <ThemeExtension<dynamic>>{
          darkBrandTheme,
        },
      ),
      themeMode: themeMode,
    );
  }
}
