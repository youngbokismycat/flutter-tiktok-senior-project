import 'dart:ui';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_senior_project/features/add/add_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/anaysis/anaysis_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/home/view/widget/crystal_nav_bar.dart';
import 'package:flutter_senior_project/features/home/vm/bottom_nav_vm.dart';
import 'package:flutter_senior_project/features/view/view_my_dairy_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final opacity = ref.watch(opacityProvider);

    final List<Widget> screens = [
      const ViewMyDairyScreen(),
      const AddMyDairyScreen(),
      const AnalysisMyDairyScreen(),
    ];

    return Scaffold(
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
