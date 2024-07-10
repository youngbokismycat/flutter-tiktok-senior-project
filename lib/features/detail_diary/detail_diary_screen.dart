import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/config/wheather_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailDiaryScreen extends HookConsumerWidget {
  const DetailDiaryScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          WeatherConfiguration.sunnyMorning,
        ],
      ),
    );
  }
}
