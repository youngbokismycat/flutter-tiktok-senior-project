import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/home/vm/bottom_nav_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavButton extends StatelessWidget {
  final int index;
  final IconData icon;
  const NavButton({
    super.key,
    required this.index,
    required this.icon,
    required this.notifier,
    required this.selectedIndex,
  });

  final BottomNavigationNotifier notifier;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => notifier.setIndex(index),
      child: AnimatedOpacity(
        duration: const Duration(
          milliseconds: 300,
        ),
        opacity: selectedIndex == index ? 1 : 0.3,
        child: FaIcon(
          icon,
        ),
      ),
    );
  }
}
