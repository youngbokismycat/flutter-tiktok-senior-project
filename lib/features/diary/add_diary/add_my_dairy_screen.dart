import 'package:animated_emoji/animated_emoji.dart';

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
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 1),
    );
    final weatherAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final isStartSelectWeather = useState(false);
    final shouldVisible = useState(false);
    final selectedEmojiIndex = useState<int?>(null);
    final selectedWeatherIndex = useState<int?>(null);

    useEffect(() {
      animationController.forward();
      return () {};
    }, [animationController]);

    useEffect(() {
      if (selectedWeatherIndex.value != null) {
        weatherAnimationController.forward();
      }
      return null;
    }, [selectedWeatherIndex.value]);

    void onMoodTap(int index) async {
      selectedEmojiIndex.value = index;
      for (int i = 0; i < 5; i++) {
        if (i != index) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            animationController.reverse(from: 1.0);
          });
        }
      }
      await Future.delayed(
        const Duration(
          milliseconds: 2200,
        ),
      );
      isStartSelectWeather.value = true;
      shouldVisible.value = true;
    }

    void onWeatherTap(int index) async {
      selectedWeatherIndex.value = index;

      await Future.delayed(const Duration(milliseconds: 500));
      isStartSelectWeather.value = false;
      shouldVisible.value = true;
    }

    final opacity0 = useMemoized(() {
      return Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.2333),
        ),
      );
    });

    final opacity1 = useMemoized(() {
      return Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.5, 0.6),
        ),
      );
    }, [animationController]);

    final emojiOpacities = useMemoized(() {
      return List.generate(5, (index) {
        double startInterval = 0.7 + index * 0.05;
        if (startInterval > 1.0) {
          startInterval = 1.0;
        }
        double endInterval = startInterval + 0.2;
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
    }, [animationController]);

    return Scaffold(
      extendBody: true,
      body: CustomAnimateGradient(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;
              final emojiSpacing = (screenWidth - 50.0 * 5) / (5 + 1);
              return Stack(
                alignment: Alignment.center,
                children: [
                  _buildAnimatedText(
                    animationController,
                    opacity0,
                    opacity1,
                    screenWidth,
                    screenHeight,
                    emojiSpacing,
                    selectedEmojiIndex.value,
                    emojiOpacities,
                    onMoodTap,
                  ),
                  _buildWeatherSelection(
                    isStartSelectWeather.value,
                    shouldVisible.value,
                    selectedWeatherIndex.value,
                    onWeatherTap,
                    weatherAnimationController,
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: WeatherConfiguration.rainyEvening),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25.0,
                        ),
                        child: ListTile(
                          leading: const AnimatedEmoji(
                            AnimatedEmojis.sad,
                            size: 32,
                          ),
                          title: TextFormField(
                            decoration: const InputDecoration(
                              fillColor: Colors.red,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: const Text(
                            '그냥 슬펐다.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, 80),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: ListTile(
                            title: Text(
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText(
    AnimationController animationController,
    Animation<double> opacity0,
    Animation<double> opacity1,
    double screenWidth,
    double screenHeight,
    double emojiSpacing,
    int? selectedEmojiIndex,
    List<Animation<double>> emojiOpacities,
    void Function(int) onMoodTap,
  ) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0, -2),
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
                  return EmojiButton(
                    index: index,
                    isSelected: selectedEmojiIndex == index,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    emojiSpacing: emojiSpacing,
                    emojiOpacity: emojiOpacities[index],
                    onMoodTap: () => onMoodTap(index),
                    selectedEmojiIndex: selectedEmojiIndex,
                    getEmoji: getEmoji,
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildWeatherSelection(
    bool isStartSelectWeather,
    bool shouldVisible,
    int? selectedWeatherIndex,
    void Function(int) onWeatherTap,
    AnimationController weatherAnimationController,
  ) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: isStartSelectWeather ? 1 : 0,
      child: Visibility(
        visible: shouldVisible,
        child: StatefulBuilder(
          builder: (context, setState) {
            return AnimatedBuilder(
              animation: weatherAnimationController,
              builder: (context, child) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '기분을 날씨로 표현해보세요!',
                        style: CustomTextTheme.whiteMedium,
                      ),
                      const Gap(30),
                      GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 9 / 12,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: WeatherConfiguration.allScenes.length,
                        itemBuilder: (context, i) {
                          final isSelected = selectedWeatherIndex == i;
                          return GestureDetector(
                            onTap: selectedWeatherIndex == null || isSelected
                                ? () {
                                    onWeatherTap(i);
                                    setState(() {});
                                  }
                                : null,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity:
                                  selectedWeatherIndex == null || isSelected
                                      ? 1.0
                                      : 0.0,
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                                scale: isSelected ? 1.1 : 1.0,
                                child: WeatherConfiguration.allScenes[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
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

  String? getLabel(int index) {
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
    }
    return null;
  }

  Widget? getWeatherLabel(int index) {
    switch (index) {
      case 0:
        return WeatherConfiguration.sunnyMorning;
      case 1:
        return WeatherConfiguration.sunnyEvening;
      case 2:
        return WeatherConfiguration.rainyMorning;
      case 3:
        return WeatherConfiguration.rainyEvening;
    }
    return null;
  }
}

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
