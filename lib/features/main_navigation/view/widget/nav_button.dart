import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/main_navigation/vm/bottom_nav_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final bool isEnabled;
  const NavButton({
    super.key,
    required this.index,
    required this.icon,
    required this.notifier,
    required this.selectedIndex,
    required this.opacityNotifier,
    this.isEnabled = true,
  });

  final BottomNavigationNotifier notifier;
  final int selectedIndex;
  final StateController<double> opacityNotifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled
          ? () {
              opacityNotifier.state = 0.0;
              Future.delayed(
                const Duration(milliseconds: 300),
                () {
                  notifier.setIndex(index);
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () {
                      opacityNotifier.state = 1.0;
                    },
                  );
                },
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: selectedIndex == index ? 1 : 0.3,
          child: FaIcon(
            icon,
            color: isEnabled ? null : Colors.grey, // Grey out if disabled
          ),
        ),
      ),
    );
  }
}
