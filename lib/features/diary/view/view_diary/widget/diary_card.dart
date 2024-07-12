import 'package:animated_emoji/animated_emoji.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';

import '../../../model/post_model.dart';

class DiaryCard extends HookConsumerWidget {
  const DiaryCard({
    super.key,
    required this.index,
    required this.post,
  });

  final int index;
  final Post post;

  void _onCardTap(BuildContext context) {
    context.pushNamed(
      RouteNames.detailDiary,
      extra: post,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = useState(1.0);
    final weatherWidget = getWeatherWidget(post.selectedWeather);
    final emoji = getEmoji(post.selectedEmoji);

    return GestureDetector(
      onTap: () => _onCardTap(context),
      onTapDown: (_) => scale.value = 0.95,
      onTapUp: (_) => scale.value = 1.0,
      onTapCancel: () => scale.value = 1.0,
      child: AnimatedScale(
        scale: scale.value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        child: SizedBox(
          height: 100,
          child: Hero(
            tag:
                'diary_${post.createAt}_${post.hashCode}', // Updated tag to match DetailDiaryCardScreen
            child: Transform.translate(
              offset: const Offset(0, 15),
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Transform.scale(
                      scale: 1.1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: weatherWidget),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 13),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: ListTile(
                          leading: AnimatedEmoji(
                            emoji,
                            size: 32,
                          ),
                          title: Text(
                            post.title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            post.subtitle,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
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
  }

  AnimatedEmojiData getEmoji(String emojiLabel) {
    switch (emojiLabel) {
      case 'Heart Eyes':
        return AnimatedEmojis.heartEyes;
      case 'Warm Smile':
        return AnimatedEmojis.warmSmile;
      case 'Slightly Happy':
        return AnimatedEmojis.slightlyHappy;
      case 'Sad':
        return AnimatedEmojis.sad;
      case 'Angry':
        return AnimatedEmojis.angry;
      default:
        return AnimatedEmojis.heartEyes;
    }
  }

  Widget getWeatherWidget(String weatherLabel) {
    switch (weatherLabel) {
      case 'WeatherConfiguration.sunnyMorning':
        return WeatherConfiguration.sunnyMorning;
      case 'WeatherConfiguration.sunnyEvening':
        return WeatherConfiguration.sunnyEvening;
      case 'WeatherConfiguration.rainyMorning':
        return WeatherConfiguration.rainyMorning;
      case 'WeatherConfiguration.rainyEvening':
        return WeatherConfiguration.rainyEvening;
      default:
        return WeatherConfiguration.sunnyMorning;
    }
  }
}
