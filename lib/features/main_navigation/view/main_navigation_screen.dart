import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/diary/view/add_diary/add_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/diary/view/analysis_diary/anaysis_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/main_navigation/view/widget/crystal_nav_bar.dart';
import 'package:flutter_senior_project/features/main_navigation/vm/bottom_nav_vm.dart';
import 'package:flutter_senior_project/features/diary/view/view_diary/view_diary_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainNavigation extends HookConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final opacity = ref.watch(opacityProvider);
    final List<Widget> screens = [
      const ViewMyDairyScreen(),
      const AddMyDairyScreen(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: screens[selectedIndex],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CrystalNavBar(),
          ),
        ],
      ),
      extendBody: true,
    );
  }
}
