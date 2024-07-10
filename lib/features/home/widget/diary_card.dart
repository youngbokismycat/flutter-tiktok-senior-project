import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:faker/faker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_animation/weather_animation.dart';

import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/common/widget/logo_gradient.dart';

class DiaryCard extends HookConsumerWidget {
  const DiaryCard({
    super.key,
    required this.index,
  });
  final int index;

  void _onCardTap(BuildContext context) {
    context.pushNamed(
      RouteNames.detailDiary,
      extra: index,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = useState(1.0);

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
            tag: '$index',
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
                          child: WeatherConfiguration.rainyEvening),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 13),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                        ),
                        child: ListTile(
                          leading: AnimatedEmoji(
                            AnimatedEmojis.sad,
                            size: 32,
                          ),
                          title: Text(
                            '오늘 너무 슬펐다.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            '그냥 슬펐다.',
                            style: TextStyle(
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
}
