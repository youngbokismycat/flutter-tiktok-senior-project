import 'dart:io';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:faker/faker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
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
      headerWidget: isDarkMode(ref)
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
          : AnimateGradient(
              duration: const Duration(seconds: 20),
              primaryBeginGeometry: const AlignmentDirectional(0, 3),
              primaryEndGeometry: const AlignmentDirectional(0, 2),
              secondaryBeginGeometry: const AlignmentDirectional(2, 0),
              secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
              textDirectionForGeometry: TextDirection.rtl,
              primaryColors: const [
                FlexColor.blueDarkPrimary,
                FlexColor.redWineDarkPrimary,
              ],
              secondaryColors: const [
                FlexColor.redWineDarkPrimary,
                FlexColor.blueDarkPrimary,
              ],
              child: Center(
                child: Text(
                  "물들다",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
            ),
      headerBottomBar: const Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Gap(10),
            itemBuilder: (context, index) => Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  24,
                ),
                border: Border.all(
                  width: 1,
                ),
              ),
              child: Text(
                faker.lorem.sentence(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
