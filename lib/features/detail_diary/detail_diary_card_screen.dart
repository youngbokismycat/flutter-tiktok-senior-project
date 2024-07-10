import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/core/config/wheather_config.dart';

class DetailDiaryCardScreen extends HookConsumerWidget {
  final int index;
  const DetailDiaryCardScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = useState(0.0);

    Future.delayed(const Duration(milliseconds: 700), () {
      opacity.value = 1.0;
    });

    return Scaffold(
      body: CustomAnimateGradient(
        child: Center(
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
                    const Padding(
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
                    Transform.translate(
                      offset: const Offset(0, 80),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: AnimatedOpacity(
                          opacity: opacity.value,
                          duration: const Duration(seconds: 1),
                          child: const Text(
                            '아침부터 기분이 안 좋았다. 날씨도 우중충하고, 머리도 띵해서 공부한 내용이 머릿속에 제대로 들어오지도 않았다. 시험지 앞에 앉았을 때, 문제들이 너무 어려워서 당황했다. 분명 공부했던 내용인데, 머릿속이 하얘졌다. 첫 문제부터 막혔고, 시간이 갈수록 더 조급해졌다. 시계 초침 소리가 점점 크게 들리는 것 같았다. 답을 적으려고 애썼지만, 자신이 없었다. 마지막 문제까지 제대로 풀지 못했다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
