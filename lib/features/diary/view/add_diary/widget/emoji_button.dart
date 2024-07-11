import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emoji_data.dart';
import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  final int index;
  final bool isSelected;
  final double screenWidth;
  final double screenHeight;
  final double emojiSpacing;
  final Animation<double> emojiOpacity;
  final VoidCallback onMoodTap;
  final int? selectedEmojiIndex;
  final AnimatedEmojiData Function(int) getEmoji;

  const EmojiButton({
    required this.index,
    required this.isSelected,
    required this.screenWidth,
    required this.screenHeight,
    required this.emojiSpacing,
    required this.emojiOpacity,
    required this.onMoodTap,
    required this.selectedEmojiIndex,
    required this.getEmoji,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 700),
      left: isSelected
          ? (screenWidth / 2 - 25)
          : emojiSpacing + index * (50.0 + emojiSpacing),
      top: isSelected ? (screenHeight / 2 - 25) : screenHeight / 2 - 25,
      child: AnimatedScale(
        curve: Curves.easeOutCirc,
        duration: const Duration(seconds: 2),
        scale: isSelected ? 1.8 : 1,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: selectedEmojiIndex != null && !isSelected
              ? 0.0
              : emojiOpacity.value,
          child: GestureDetector(
            onTap: onMoodTap,
            child: AnimatedEmoji(
              getEmoji(index),
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
