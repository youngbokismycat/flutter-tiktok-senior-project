import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/core/theme/text_theme.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddMyDairyScreen extends HookConsumerWidget {
  const AddMyDairyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity0 = useState(0.0);
    final opacity1 = useState(0.0);
    final emojiOpacities = [
      useState(0.0),
      useState(0.0),
      useState(0.0),
      useState(0.0),
      useState(0.0)
    ];
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

    for (int i = 0; i < emojiOpacities.length; i++) {
      Future.delayed(Duration(milliseconds: 2100 + i * 300), () {
        emojiOpacities[i].value = 1.0;
      });
    }

    void onMoodTap() {}

    return Scaffold(
      extendBody: true,
      body: CustomAnimateGradient(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final emojiSpacing =
                  (screenWidth - 50.0 * emojiOpacities.length) /
                      (emojiOpacities.length + 1);

              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedSlide(
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 700),
                    offset: Offset(0, y.value),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      opacity: opacity0.value,
                      child: const Text(
                        "Youngbok 님! 지금은 어떤 기분이신가요?",
                        style: CustomTextTheme.whiteMedium,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity1.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(emojiOpacities.length, (index) {
                        return Positioned(
                          left: emojiSpacing + index * (50.0 + emojiSpacing),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: emojiOpacities[index].value,
                            child: EmojiButton(
                              emoji: getEmoji(index),
                              label: getLabel(index),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  AnimatedEmojiData getEmoji(int index) {
    switch (index) {
      case 0:
        return AnimatedEmojis.heartEyes;
      case 1:
        return AnimatedEmojis.warmSmile;
      case 2:
        return AnimatedEmojis.slightlyHappy;
      case 3:
        return AnimatedEmojis.sad;
      case 4:
        return AnimatedEmojis.angry;
      default:
        return AnimatedEmojis.heartEyes;
    }
  }

  String getLabel(int index) {
    switch (index) {
      case 0:
        return 'Heart Eyes';
      case 1:
        return 'Warm Smile';
      case 2:
        return 'Slightly Happy';
      case 3:
        return 'Sad';
      case 4:
        return 'Angry';
      default:
        return 'Heart Eyes';
    }
  }
}

class EmojiButton extends StatelessWidget {
  final AnimatedEmojiData emoji;
  final String label;

  const EmojiButton({required this.emoji, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('$label emoji tapped');
      },
      child: AnimatedEmoji(
        emoji,
        size: 50,
      ),
    );
  }
}
