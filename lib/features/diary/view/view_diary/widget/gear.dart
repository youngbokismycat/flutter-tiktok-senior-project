import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Gear extends StatelessWidget {
  final Function() onTap;
  const Gear({
    super.key,
    required this.onTap,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Align(
        alignment: Alignment.centerRight,
        child: FaIcon(
          FontAwesomeIcons.gear,
          color: Colors.white,
        ),
      ),
    );
  }
}
