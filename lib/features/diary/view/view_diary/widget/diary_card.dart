import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emoji_data.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/vm/fetch_post_vm.dart';

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

  Future<void> _onDeletePost(BuildContext context, WidgetRef ref) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('다이어리 삭제ㅜㅜ'),
          content: const Text('진짜 다이어리를 삭제하시겠어요...?????'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('뭐야 아니요 잘못눌렀어요'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('네!'),
            ),
          ],
        );
      },
    );

    if (confirmDelete ?? false) {
      final postRepository = ref.read(postRepositoryProvider);
      await postRepository.deletePost(post.id!);
      ref.read(fetchPostsViewModelProvider.notifier).fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = useState(1.0);
    final weatherWidget = getWeatherWidget(post.selectedWeather);
    final emoji = getEmoji(post.selectedEmoji);

    return GestureDetector(
      onTap: () => _onCardTap(context),
      onLongPress: () => _onDeletePost(context, ref), // Add this line
      onTapDown: (_) => scale.value = 0.95,
      onTapUp: (_) => scale.value = 1.0,
      onTapCancel: () => scale.value = 1.0,
      child: AnimatedScale(
        scale: scale.value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: Hero(
                tag: 'diary_${post.createAt}_${post.hashCode}',
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
                            child: weatherWidget,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, 13),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
