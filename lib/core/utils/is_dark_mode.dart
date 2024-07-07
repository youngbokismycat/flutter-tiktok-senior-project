import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define a provider for ThemeMode
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

bool isDarkMode(WidgetRef ref) {
  return ref.read(themeModeProvider) == ThemeMode.dark;
}

// Utility method to check if the system theme is dark
bool isSystemDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}
