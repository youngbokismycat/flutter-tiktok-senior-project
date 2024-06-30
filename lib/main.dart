import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      title: 'Mood tracker',
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.mandyRed,
      ),
    );
  }
}
