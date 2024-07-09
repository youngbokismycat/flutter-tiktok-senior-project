import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_senior_project/core/config/app_config.dart';
import 'package:flutter_senior_project/core/firebase/firebase_options.dart';
import 'package:flutter_senior_project/core/router/router.dart';
import 'package:flutter_senior_project/core/theme/brand_theme.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  final ThemeMode themeMode = ThemeMode.system;

  final bool useMaterial3 = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: '물들다 : The Mood Changer',
      theme: FlexThemeData.light(
        useMaterial3: useMaterial3,
        colors: AppConfig.useScheme ? null : AppConfig.schemeLight,
        scheme: AppConfig.scheme,
        swapColors: AppConfig.swapColors,
        usedColors: AppConfig.usedColors,
        lightIsWhite: true,
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
        appBarBackground: darkModeColor,
        scaffoldBackground: darkModeColor,
        background: darkModeColor,
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
      themeMode: isDarkMode(ref) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
