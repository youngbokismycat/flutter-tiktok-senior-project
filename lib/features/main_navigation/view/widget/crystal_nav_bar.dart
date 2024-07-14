import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/common/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/common/vm/showcase_vm.dart';
import 'package:flutter_senior_project/features/main_navigation/view/widget/nav_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_senior_project/features/main_navigation/vm/bottom_nav_vm.dart';
import 'package:showcaseview/showcaseview.dart';

class CrystalNavBar extends HookConsumerWidget {
  const CrystalNavBar({super.key});

  Future<bool> _isChartSimpleButtonEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    int seasonCount = 0;
    for (int i = 0; i < 4; i++) {
      if ((prefs.getInt('weather_$i') ?? 0) > 0) {
        seasonCount++;
      }
    }

    int emojiCount = 0;
    for (int i = 0; i < 5; i++) {
      if ((prefs.getInt('emoji_$i') ?? 0) > 0) {
        emojiCount++;
      }
    }

    return seasonCount >= 4 && emojiCount >= 5;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(showcaseVMProvider);
    final selectedIndex = ref.watch(bottomNavigationProvider);
    final notifier = ref.read(bottomNavigationProvider.notifier);
    final opacityNotifier = ref.read(opacityProvider.notifier);

    return FutureBuilder<bool>(
      future: _isChartSimpleButtonEnabled(),
      builder: (context, snapshot) {
        final isChartSimpleEnabled = snapshot.data ?? false;
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
                filter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: isDarkMode(ref)
                          ? Colors.grey.shade500
                          : Colors.white24,
                    ),
                    color: isDarkMode(ref)
                        ? Colors.grey.shade800.withOpacity(0.5)
                        : Colors.grey.shade200.withOpacity(0.5),
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
                        Showcase(
                          key: vm.keyOne,
                          description: "일기를 클릭하면 전문을 볼 수 있어요!",
                          title: '일기를 한 눈에 볼 수 있는 곳이에요!',
                          child: NavButton(
                            notifier: notifier,
                            selectedIndex: selectedIndex,
                            opacityNotifier: opacityNotifier,
                            icon: FontAwesomeIcons.house,
                            index: 0,
                          ),
                        ),
                        Showcase(
                          key: vm.keyTwo,
                          description: "멋진 일기장을 만들 수 있어요!",
                          title: '일기를 쓸 수 있는 곳이에요!',
                          child: NavButton(
                            notifier: notifier,
                            selectedIndex: selectedIndex,
                            opacityNotifier: opacityNotifier,
                            icon: FontAwesomeIcons.penToSquare,
                            index: 1,
                          ),
                        ),
                        Showcase(
                          key: vm.keyThree,
                          title: "일기의 통계를 확인할 수 있는 곳이에요!",
                          description: '일기를 많이 쓰다보면 해금될거에요!',
                          child: NavButton(
                            notifier: notifier,
                            selectedIndex: selectedIndex,
                            opacityNotifier: opacityNotifier,
                            icon: FontAwesomeIcons.chartSimple,
                            index: 2,
                            isEnabled: isChartSimpleEnabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
