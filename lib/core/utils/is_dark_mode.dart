import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isDarkModeProvider = Provider<bool>((ref) {
  final brightness = PlatformDispatcher.instance.platformBrightness;
  return brightness == Brightness.dark;
});
bool isDarkMode(WidgetRef ref) {
  final isDarkMode = ref.read(isDarkModeProvider);
  return isDarkMode;
}
