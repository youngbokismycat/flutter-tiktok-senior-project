import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/common/utils/transition_animation.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opacity = useState(1.0);
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(
          milliseconds: 300,
        ),
        opacity: opacity.value,
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "무드 부스팅",
              body: "일기를 쓰는 것은 기분을 나아지게 하는 효과가 있습니다.",
              image: const Center(
                child: Icon(Icons.book, size: 100.0, color: Colors.blue),
              ),
            ),
            PageViewModel(
              title: "무드 트래킹",
              body: "일기를 쓰기 전과 후의 감정을 기록할 수 있습니다.",
              image: const Center(
                child: Icon(Icons.sentiment_satisfied,
                    size: 100.0, color: Colors.green),
              ),
            ),
            PageViewModel(
              title: "긍정적인 기분을 위한 팁",
              body: "긍정적인 기분일 때는 지금 왜 그런 기분을 느끼는지 구체적으로 적어보는 것이 좋습니다.",
              image: const Center(
                child: Icon(Icons.sentiment_very_satisfied,
                    size: 100.0, color: Colors.orange),
              ),
            ),
            PageViewModel(
              title: "부정적인 기분을 위한 팁",
              body: "부정적인 기분일 때는 왜 그런 기분을 느끼는지 이해하기 위한 일기를 쓰는 것이 좋습니다.",
              image: const Center(
                child: Icon(Icons.sentiment_dissatisfied,
                    size: 100.0, color: Colors.red),
              ),
            ),
            PageViewModel(
              titleWidget: const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "그것을 돕기 위해 ",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomShader(
                    child: Text(
                      "물들다",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    " 가 있습니다.",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              bodyWidget: const Column(
                children: [
                  Text(
                    '당신이 행복했으면 좋겠습니다.',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  Gap(20),
                  Text(
                    "준비 되셨나요?!",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
              image: const Center(
                child: CustomShader(
                  child: Icon(
                    Icons.sentiment_satisfied_alt,
                    color: Colors.white,
                    size: 105,
                  ),
                ),
              ),
            ),
          ],
          onDone: () async {
            transitionAnimationPushNamedAndReplace(
              context: context,
              opacity: opacity,
              routeName: RouteNames.home,
            );
          },
          onSkip: () async {
            transitionAnimationPushNamedAndReplace(
              context: context,
              opacity: opacity,
              routeName: RouteNames.home,
            );
          },
          showSkipButton: true,
          skip: const Text("스킵하기"),
          next: const Icon(Icons.arrow_forward),
          done:
              const Text("시작하기", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }
}
