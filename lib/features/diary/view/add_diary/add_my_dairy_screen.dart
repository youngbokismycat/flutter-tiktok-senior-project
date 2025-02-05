import 'package:animated_emoji/animated_emoji.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/vm/post_vm.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/core/theme/text_theme.dart';
import 'package:flutter_senior_project/features/diary/view/add_diary/widget/emoji_button.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMyDiaryScreen extends HookConsumerWidget {
  const AddMyDiaryScreen({super.key});

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
    final shouldSubmit = useState(false);
    final shouldSlide = useState(false);
    final shouldVisibleSelectedCards = useState(false);
    final selectedEmojiIndex = useState<int?>(null);
    final selectedWeatherIndex = useState<int?>(null);

    final TextEditingController titleController = useTextEditingController();
    final TextEditingController subtitleController = useTextEditingController();
    final TextEditingController diaryEntryController =
        useTextEditingController();

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
        isButtonEnabled.value = titleController.text.isNotEmpty &&
            subtitleController.text.isNotEmpty &&
            diaryEntryController.text.isNotEmpty;
      }

      titleController.addListener(listener);
      subtitleController.addListener(listener);
      diaryEntryController.addListener(listener);

      return () {
        titleController.removeListener(listener);
        subtitleController.removeListener(listener);
        diaryEntryController.removeListener(listener);
      };
    }, [titleController, subtitleController, diaryEntryController]);

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

    void onSubmit() async {
      final post = Post(
        selectedEmoji: getLabel(selectedEmojiIndex.value!)!,
        selectedWeather: getWeatherLabel(selectedWeatherIndex.value!)!,
        title: titleController.text,
        subtitle: subtitleController.text,
        diaryEntry: diaryEntryController.text,
        createAt: DateTime.now().millisecondsSinceEpoch.toDouble(),
      );

      ref.read(addPostViewModelProvider.notifier).addPost(post);

      // Save selections to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String emojiKey = 'emoji_${selectedEmojiIndex.value}';
      String weatherKey = 'weather_${selectedWeatherIndex.value}';

      int emojiCount = prefs.getInt(emojiKey) ?? 0;
      int weatherCount = prefs.getInt(weatherKey) ?? 0;

      await prefs.setInt(emojiKey, emojiCount + 1);
      await prefs.setInt(weatherKey, weatherCount + 1);

      isButtonEnabled.value = false;
      FocusScope.of(context).unfocus();
      await Future.delayed(
        const Duration(
          seconds: 1,
        ),
      );
      shouldSubmit.value = true;
      isButtonEnabled.value = false;
      await Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        shouldSlide.value = true;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  AnimatedSlide(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    curve: Curves.easeInQuint,
                    offset: Offset(shouldSlide.value ? -1 : 0, 0),
                    child: AnimatedContainer(
                      duration: const Duration(
                        seconds: 1,
                      ),
                      curve: Curves.decelerate,
                      height: shouldSubmit.value ? 100 : 550,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: shouldVisibleSelectedCards.value
                            ? _buildSelectedWeatherAndEmoji(
                                selectedWeatherIndex.value!,
                                shouldSubmit.value,
                                selectedEmojiIndex.value!,
                                titleController,
                                subtitleController,
                                diaryEntryController,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(
                      seconds: 2,
                    ),
                    curve: Curves.easeOutCirc,
                    top: isButtonEnabled.value ? -170 : -300,
                    right: 20,
                    child: HookBuilder(builder: (context) {
                      return Column(
                        children: [
                          const TwoString(),
                          ElevatedButton(
                            onPressed: () => onSubmit(),
                            child: const Text('다 썼어요!'),
                          ),
                        ],
                      );
                    }),
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
    bool shouldSubmit,
    int emojiIndex,
    TextEditingController titleController,
    TextEditingController subtitleController,
    TextEditingController diaryEntryController,
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
            child: Transform.translate(
              offset: Offset(
                0,
                shouldSubmit ? 13 : 0,
              ),
              child: ListTile(
                leading: AnimatedEmoji(
                  getEmoji(emojiIndex),
                  size: 40,
                ),
                title: DiaryTextFormField(
                  controller: titleController,
                  height: 30,
                  hintText: '오늘 하루는 어떠신가요?',
                  maxLines: 1,
                  textSize: 17,
                ),
                subtitle: DiaryTextFormField(
                  controller: subtitleController,
                  height: 30,
                  hintText: '어떤 기분을 갖고 계신가요?',
                  maxLines: 1,
                  textSize: 15,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(
              milliseconds: 200,
            ),
            opacity: shouldSubmit ? 0 : 1,
            child: Transform.translate(
              offset: const Offset(0, 80),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListTile(
                  title: DiaryTextFormField(
                    controller: diaryEntryController,
                    textInputType: TextInputType.multiline,
                    height: 450,
                    hintText: '자유롭게 일기를 적어주세요!',
                    textSize: 20,
                    maxLines: 10,
                  ),
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

  String? getWeatherLabel(int index) {
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

class TwoString extends StatelessWidget {
  const TwoString({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.translate(
          offset: const Offset(30, 30),
          child: Container(
            width: 3,
            height: 250,
            color: Colors.brown.shade900,
          ),
        ),
        Transform.translate(
          offset: const Offset(-30, 30),
          child: Container(
            width: 3,
            height: 250,
            color: Colors.brown.shade900,
          ),
        ),
      ],
    );
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
