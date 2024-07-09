import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier();
});

final opacityProvider = StateProvider<double>((ref) => 1.0);
