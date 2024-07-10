import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/theme/text_theme.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddMyDairyScreen extends HookConsumerWidget {
  const AddMyDairyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity0 = useState(0.0);
    final opacity1 = useState(0.0);
    final y = useState(0.0);
    Future.delayed(const Duration(milliseconds: 700), () {
      opacity0.value = 1.0;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      y.value = -1.5;
    });
    Future.delayed(const Duration(milliseconds: 1800), () {
      opacity1.value = 1.0;
    });
    return Scaffold(
      extendBody: true,
      body: CustomAnimateGradient(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedSlide(
                curve: Curves.ease,
                duration: const Duration(
                  milliseconds: 700,
                ),
                offset: Offset(0, y.value),
                child: AnimatedOpacity(
                  duration: const Duration(
                    milliseconds: 700,
                  ),
                  opacity: opacity0.value,
                  child: const Text(
                    "Youngbok 님! 지금은 어떤 기분이신가요?",
                    style: CustomTextTheme.whiteMedium,
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(
                  milliseconds: 300,
                ),
                opacity: opacity1.value,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [AnimatedEmoji(AnimatedEmojis.airplaneArrival)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
