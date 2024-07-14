import 'package:animated_emoji/animated_emoji.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_animation/weather_animation.dart';

class AnalysisMyDiaryScreen extends StatefulWidget {
  const AnalysisMyDiaryScreen({super.key});

  @override
  State<StatefulWidget> createState() => AnalysisMyDiaryScreenState();
}

class AnalysisMyDiaryScreenState extends State<AnalysisMyDiaryScreen> {
  int touchedWeatherIndex = -1;
  int touchedEmojiIndex = -1;
  Map<String, int> emojiStats = {};
  Map<String, int> weatherStats = {};

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, int> tempEmojiStats = {};
    Map<String, int> tempWeatherStats = {};

    List<String> emojiKeys = [
      'emoji_0',
      'emoji_1',
      'emoji_2',
      'emoji_3',
      'emoji_4'
    ];
    List<String> weatherKeys = [
      'weather_0',
      'weather_1',
      'weather_2',
      'weather_3'
    ];

    for (String emojiKey in emojiKeys) {
      int emojiCount = prefs.getInt(emojiKey) ?? 0;
      tempEmojiStats[emojiKey] = emojiCount;
    }

    for (String weatherKey in weatherKeys) {
      int weatherCount = prefs.getInt(weatherKey) ?? 0;
      tempWeatherStats[weatherKey] = weatherCount;
    }

    setState(() {
      emojiStats = tempEmojiStats;
      weatherStats = tempWeatherStats;
    });
  }

  List<PieChartSectionData> showingWeatherSections() {
    int totalWeather = weatherStats.values.fold(0, (sum, item) => sum + item);

    return List.generate(weatherStats.length, (i) {
      final isTouched = i == touchedWeatherIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double value = weatherStats['weather_$i']?.toDouble() ?? 0.0;
      String title = totalWeather == 0
          ? '0%'
          : '${((value / totalWeather) * 100).toStringAsFixed(1)}%';

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF2b53b2),
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              size: widgetSize * 1.1,
              borderColor: Colors.black,
              child: WeatherConfiguration.sunnyMorning,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFFed7355),
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              size: widgetSize * 1.1,
              borderColor: Colors.black,
              child: WeatherConfiguration.sunnyEvening,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFc1ccd2),
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              size: widgetSize * 1.1,
              borderColor: Colors.black,
              child: WeatherConfiguration.rainyMorning,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFF4e6571),
            value: value,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              size: widgetSize * 1.1,
              borderColor: Colors.black,
              child: WeatherConfiguration.rainyEvening,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }

  List<PieChartSectionData> showingEmojiSections() {
    int totalEmoji = emojiStats.values.fold(0, (sum, item) => sum + item);

    return List.generate(emojiStats.length, (i) {
      final isTouched = i == touchedEmojiIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      double value = emojiStats['emoji_$i']?.toDouble() ?? 0.0;
      String title = totalEmoji == 0
          ? '0%'
          : '${((value / totalEmoji) * 100).toStringAsFixed(1)}%';

      Color color;
      switch (i) {
        case 0:
          color = Colors.pink; // Heart Eyes
          break;
        case 1:
          color = Colors.orange; // Warm Smile
          break;
        case 2:
          color = Colors.yellow; // Slightly Happy
          break;
        case 3:
          color = Colors.blue; // Sad
          break;
        case 4:
          color = Colors.red; // Angry
          break;
        default:
          color = Colors.grey; // Unknown
      }

      return PieChartSectionData(
        color: color,
        value: value,
        title: title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          size: widgetSize * 1.1,
          borderColor: Colors.black,
          child: _getEmoji(i),
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }

  AnimatedEmoji _getEmoji(int index) {
    switch (index) {
      case 0:
        return const AnimatedEmoji(AnimatedEmojis.heartEyes); // Heart Eyes
      case 1:
        return const AnimatedEmoji(AnimatedEmojis.warmSmile); // Warm Smile
      case 2:
        return const AnimatedEmoji(
            AnimatedEmojis.slightlyHappy); // Slightly Happy
      case 3:
        return const AnimatedEmoji(AnimatedEmojis.sad); // Sad
      case 4:
        return const AnimatedEmoji(AnimatedEmojis.angry); // Angry
      default:
        return const AnimatedEmoji(AnimatedEmojis.question); // Unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAnimateGradient(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(30),
                const Text(
                  '계절 통계에요!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedWeatherIndex = -1;
                                return;
                              }
                              touchedWeatherIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingWeatherSections(),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -70),
                  child: const Text(
                    '이모지 통계에요!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -105),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedEmojiIndex = -1;
                                return;
                              }
                              touchedEmojiIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingEmojiSections(),
                      ),
                    ),
                  ),
                ),
                const Gap(
                  50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.size,
    required this.borderColor,
    required this.child,
  });

  final double size;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      clipBehavior: Clip.hardEdge,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Transform.scale(scale: 1, child: child),
    );
  }
}
