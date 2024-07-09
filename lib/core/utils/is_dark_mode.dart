import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier()
      : super(
            PlatformDispatcher.instance.platformBrightness == Brightness.dark) {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      // Update the state based on the new brightness
      state = PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    };
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});

bool isDarkMode(WidgetRef ref) {
  final isDarkMode = ref.watch(darkModeProvider);
  return isDarkMode;
}
