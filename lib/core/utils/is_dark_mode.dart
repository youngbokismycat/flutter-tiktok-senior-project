import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier()
      : super(
            PlatformDispatcher.instance.platformBrightness == Brightness.dark) {
    // Listen for platform brightness changes
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      // Update the state based on the new brightness
      state = PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    };
  }
}

// Provider for DarkModeNotifier
final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

// Function to get the current dark mode status
bool isDarkMode(WidgetRef ref) {
  final isDarkMode = ref.watch(darkModeProvider);
  return isDarkMode;
}
