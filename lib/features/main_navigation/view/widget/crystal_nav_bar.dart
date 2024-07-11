import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/main_navigation/view/widget/nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/features/main_navigation/vm/bottom_nav_vm.dart';

class CrystalNavBar extends HookConsumerWidget {
  const CrystalNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final notifier = ref.read(bottomNavigationProvider.notifier);
    final opacityNotifier = ref.read(opacityProvider.notifier);

    return BottomAppBar(
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            blendMode: BlendMode.src,
            filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color:
                      isDarkMode(ref) ? Colors.grey.shade500 : Colors.white24,
                ),
                color: (isDarkMode(ref)
                    ? Colors.grey.shade800.withOpacity(0.5)
                    : Colors.grey.shade200.withOpacity(0.5)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 0,
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavButton(
                      notifier: notifier,
                      selectedIndex: selectedIndex,
                      opacityNotifier: opacityNotifier,
                      icon: FontAwesomeIcons.house,
                      index: 0,
                    ),
                    NavButton(
                      notifier: notifier,
                      selectedIndex: selectedIndex,
                      opacityNotifier: opacityNotifier,
                      icon: FontAwesomeIcons.chartSimple,
                      index: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
