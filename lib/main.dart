import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/config/app_config.dart';
import 'package:flutter_senior_project/core/router/router.dart';
import 'package:flutter_senior_project/core/theme/brand_theme.dart';
import 'package:flutter_senior_project/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_twitter/firebase_ui_oauth_twitter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);
final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: actionCodeSettings,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        AndroidProvider.playIntegrity, // or AndroidProvider.safetyNet
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
      clientId: "this is id",
      iOSPreferPlist: true,
    ),
  ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class KoreanLocalizations extends DefaultLocalizations {
  const KoreanLocalizations();
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
      locale: const Locale('ko', ''),
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('ko', ''), // Korean
      ],
      localizationsDelegates: [
        FirebaseUILocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
        appBarBackground: const Color(0xFF121212),
        scaffoldBackground: const Color(0xFF121212),
        background: const Color(0xFF121212),
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
