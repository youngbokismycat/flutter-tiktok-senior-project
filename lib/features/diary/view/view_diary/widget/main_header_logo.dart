import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/common/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainHeaderLogo extends ConsumerWidget {
  const MainHeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isDarkMode(ref)
        ? Container(
            color: isDarkMode(ref)
                ? Platform.isAndroid
                    ? darkModeColor
                    : const Color.fromARGB(255, 25, 25, 25)
                : Colors.white,
            child: Center(
              child: CustomShader(
                child: Text(
                  "물들다",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
            ),
          )
        : CustomAnimateGradient(
            child: Center(
              child: Text(
                "물들다",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
          );
  }
}
