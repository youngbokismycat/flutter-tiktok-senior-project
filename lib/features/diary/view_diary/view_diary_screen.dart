import 'dart:io';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:faker/faker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/diary/add_diary/add_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
import 'package:flutter_senior_project/features/diary/detail_diary/detail_diary_card_screen.dart';
import 'package:flutter_senior_project/features/diary/view_diary/widget/diary_card.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewMyDairyScreen extends ConsumerStatefulWidget {
  const ViewMyDairyScreen({super.key});

  @override
  ViewMyDairyScreenState createState() => ViewMyDairyScreenState();
}

class ViewMyDairyScreenState extends ConsumerState<ViewMyDairyScreen> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      expandedBody: const AddMyDairyScreen(),
      fullyStretchable: true,
      backgroundColor: isDarkMode(ref)
          ? const Color.fromARGB(255, 35, 35, 35)
          : Colors.white,
      title: const CustomShader(
        child: Text(
          "물들다",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      headerWidget: const HeaderWidget(),
      body: const [
        Diaries(),
      ],
    );
  }
}

class Diaries extends StatelessWidget {
  const Diaries({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Gap(10),
      itemBuilder: (context, index) => DiaryCard(index: index),
    );
  }
}

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return isDarkMode(ref)
        ? Container(
            color: isDarkMode(ref)
                ? Platform.isAndroid
                    ? darkModeColor
                    : const Color.fromARGB(255, 25, 25, 25)
                : Colors.white,
            child: Center(
              child: CustomShader(
                child: Text(
                  "물들다",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
            ),
          )
        : CustomAnimateGradient(
            child: Center(
              child: Text(
                "물들다",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.white70),
              ),
            ),
          );
  }
}
