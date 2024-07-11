import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/diary/view/add_diary/widget/emoji_button.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/theme/text_theme.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'dart:convert';

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
    final shouldVisibleCards = useState(false);
    final shouldVisibleSelectedCards = useState(false);
    final selectedEmojiIndex = useState<int?>(null);
    final selectedWeatherIndex = useState<int?>(null);

    final TextEditingController controller1 = useTextEditingController();
    final TextEditingController controller2 = useTextEditingController();
    final TextEditingController controller3 = useTextEditingController();

    final isButtonEnabled = useState(false);

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

    useEffect(() {
      void listener() {
        isButtonEnabled.value = controller1.text.isNotEmpty &&
            controller2.text.isNotEmpty &&
            controller3.text.isNotEmpty;
      }

      controller1.addListener(listener);
      controller2.addListener(listener);
      controller3.addListener(listener);

      return () {
        controller1.removeListener(listener);
        controller2.removeListener(listener);
        controller3.removeListener(listener);
      };
    }, [controller1, controller2, controller3]);

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
      shouldVisibleCards.value = true;
    }

    void onWeatherTap(int index) async {
      selectedWeatherIndex.value = index;

      await Future.delayed(const Duration(milliseconds: 500));
      isStartSelectWeather.value = false;
      shouldVisibleCards.value = true;

      await Future.delayed(const Duration(seconds: 1));
      shouldVisibleSelectedCards.value = true;
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
                    shouldVisibleCards.value,
                    selectedWeatherIndex.value,
                    onWeatherTap,
                    weatherAnimationController,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: shouldVisibleSelectedCards.value
                        ? _buildSelectedWeatherAndEmoji(
                            selectedWeatherIndex.value!,
                            selectedEmojiIndex.value!,
                            controller1,
                            controller2,
                            controller3,
                          )
                        : const SizedBox(),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled.value
                          ? () {
                              final postData = {
                                'selectedEmoji':
                                    getLabel(selectedEmojiIndex.value!),
                                'selectedWeather': getWeatherLable(
                                  selectedWeatherIndex.value!,
                                ),
                                'title': controller1.text,
                                'subtitle': controller2.text,
                                'diaryEntry': controller3.text,
                              };
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Data saved: ${jsonEncode(postData)}')));
                            }
                          : null,
                      child: const Text('Complete'),
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
    bool shouldVisibleCards,
    int? selectedWeatherIndex,
    void Function(int) onWeatherTap,
    AnimationController weatherAnimationController,
  ) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isStartSelectWeather ? 1 : 0,
      child: Visibility(
        visible: shouldVisibleCards,
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
                        '날씨카드를 고르세요!',
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
                                scale: isSelected ? 1.05 : 1.0,
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

  Widget _buildSelectedWeatherAndEmoji(
    int weatherIndex,
    int emojiIndex,
    TextEditingController controller1,
    TextEditingController controller2,
    TextEditingController controller3,
  ) {
    return Form(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Transform.scale(
            scale: 1.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: WeatherConfiguration.allScenes[weatherIndex],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListTile(
              leading: AnimatedEmoji(
                getEmoji(emojiIndex),
                size: 40,
              ),
              title: DiaryTextFormField(
                controller: controller1,
                height: 30,
                hintText: '오늘 하루는 어떠신가요?',
                maxLines: 1,
                textSize: 17,
              ),
              subtitle: DiaryTextFormField(
                controller: controller2,
                height: 30,
                hintText: '어떤 기분을 갖고 계신가요?',
                maxLines: 1,
                textSize: 15,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListTile(
                title: DiaryTextFormField(
                  controller: controller3,
                  textInputType: TextInputType.multiline,
                  height: 450,
                  hintText: '자유롭게 일기를 적어주세요!',
                  textSize: 20,
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ],
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

  String? getWeatherLable(int index) {
    switch (index) {
      case 0:
        return 'WeatherConfiguration.sunnyMorning';
      case 1:
        return 'WeatherConfiguration.sunnyEvening';
      case 2:
        return 'WeatherConfiguration.rainyMorning';
      case 3:
        return 'WeatherConfiguration.rainyEvening';
    }
    return null;
  }
}

Widget? getWeather(int index) {
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

class DiaryTextFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final double textSize;
  final bool isExpandable;
  final int? maxLength;
  final int? maxLines;
  final TextInputType textInputType;
  final TextEditingController controller;

  const DiaryTextFormField({
    super.key,
    required this.hintText,
    required this.height,
    required this.textSize,
    this.isExpandable = false,
    this.textInputType = TextInputType.text,
    this.maxLength,
    this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        minLines: null,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: textInputType,
        clipBehavior: Clip.none,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade100,
            fontSize: textSize,
            shadows: const [
              Shadow(
                blurRadius: 30,
              )
            ],
          ),
          fillColor: Colors.transparent,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: textSize,
          shadows: const [
            Shadow(
              blurRadius: 30,
            )
          ],
        ),
      ),
    );
  }
}
