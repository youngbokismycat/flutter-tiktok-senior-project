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
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 2000),
    );

    final selectedEmojiIndex = useState<int?>(null);

    useEffect(() {
      animationController.forward();
      return () {};
    }, [animationController]);

    void onMoodTap(int index) {
      selectedEmojiIndex.value = index;
      for (int i = 0; i < 5; i++) {
        if (i != index) {
          Future.delayed(
              const Duration(
                milliseconds: 1000,
              ), () {
            animationController.reverse(from: 1.0);
          });
        }
      }
    }

    return Scaffold(
      extendBody: true,
      body: CustomAnimateGradient(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final emojiSpacing =
                  (screenWidth - 50.0 * 5) / (5 + 1); // 5 emojis hardcoded

              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      final opacity0 = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: const Interval(0.0, 0.2333),
                        ),
                      );

                      final yOffset = Tween(begin: 0.0, end: -1.5).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: const Interval(0.2333, 0.5),
                        ),
                      );

                      final opacity1 = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: const Interval(0.5, 0.6),
                        ),
                      );

                      final emojiOpacities = List.generate(5, (index) {
                        double startInterval = 0.7 + index * 0.05;
                        double endInterval = startInterval + 0.1;
                        if (endInterval > 1.0) {
                          endInterval = 1.0;
                        }
                        return Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Interval(startInterval, endInterval),
                          ),
                        );
                      });

                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: Offset(0, yOffset.value),
                            ).animate(CurvedAnimation(
                              parent: animationController,
                              curve: Curves.ease,
                            )),
                            child: Opacity(
                              opacity: opacity0.value,
                              child: const Text(
                                "Youngbok 님! 지금은 어떤 기분이신가요?",
                                style: CustomTextTheme.whiteMedium,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: opacity1.value,
                            child: Stack(
                              alignment: Alignment.center,
                              children: List.generate(5, (index) {
                                final isSelected =
                                    selectedEmojiIndex.value == index;
                                return AnimatedPositioned(
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 700),
                                  left: isSelected
                                      ? (screenWidth / 2 - 25)
                                      : emojiSpacing +
                                          index * (50.0 + emojiSpacing),
                                  top: isSelected
                                      ? (screenHeight / 2 - 25)
                                      : screenHeight / 2 - 25,
                                  child: AnimatedScale(
                                    curve: Curves.easeOutCirc,
                                    duration: const Duration(
                                      seconds: 2,
                                    ),
                                    scale: isSelected ? 2 : 1,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity:
                                          selectedEmojiIndex.value != null &&
                                                  !isSelected
                                              ? 0.0
                                              : emojiOpacities[index].value,
                                      child: EmojiButton(
                                        emoji: getEmoji(index),
                                        label: getLabel(index),
                                        onTap: () => onMoodTap(index),
                                      ),
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
  final VoidCallback onTap;

  const EmojiButton({
    required this.emoji,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedEmoji(
        emoji,
        size: 50,
      ),
    );
  }
}
