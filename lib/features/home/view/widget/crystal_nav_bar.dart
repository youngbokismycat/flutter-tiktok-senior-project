import 'dart:ui';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/home/view/widget/nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/features/home/vm/bottom_nav_vm.dart';

class CrystalNavBar extends HookConsumerWidget {
  const CrystalNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final notifier = ref.read(bottomNavigationProvider.notifier);

    return BottomAppBar(
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white24),
                color: Colors.grey.shade200,
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
                      icon: FontAwesomeIcons.house,
                      index: 0,
                    ),
                    NavButton(
                      notifier: notifier,
                      selectedIndex: selectedIndex,
                      icon: FontAwesomeIcons.plus,
                      index: 1,
                    ),
                    NavButton(
                      notifier: notifier,
                      selectedIndex: selectedIndex,
                      icon: FontAwesomeIcons.chartSimple,
                      index: 2,
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
