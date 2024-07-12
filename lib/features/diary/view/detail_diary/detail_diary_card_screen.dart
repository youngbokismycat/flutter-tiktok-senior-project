import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/core/config/wheather_config.dart';

class DetailDiaryCardScreen extends HookConsumerWidget {
  final Post post;
  const DetailDiaryCardScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = useState(0.0);

    Future.delayed(const Duration(milliseconds: 700), () {
      opacity.value = 1.0;
    });

    final weatherWidget = getWeatherWidget(post.selectedWeather);
    final emoji = getEmoji(post.selectedEmoji);

    return GestureDetector(
      onTap: () => context.pop(),
      child: Scaffold(
        body: CustomAnimateGradient(
          child: Center(
            child: Hero(
              tag: 'diary_${post.createAt}_${post.hashCode}',
              child: Transform.translate(
                offset: const Offset(
                  0,
                  15,
                ),
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
                      Padding(
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
                          trailing: Text(
                            "${post.getElapsedTime()} 전",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, 80),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: AnimatedOpacity(
                            opacity: opacity.value,
                            duration: const Duration(seconds: 1),
                            child: ListTile(
                              title: Text(
                                post.diaryEntry,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
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
