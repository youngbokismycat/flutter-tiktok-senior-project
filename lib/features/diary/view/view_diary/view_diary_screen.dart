import 'dart:io';

import 'package:draggable_home/draggable_home.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/core/theme/text_theme.dart';
import 'package:flutter_senior_project/features/common/vm/showcase_vm.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/view/view_diary/widget/gear.dart';
import 'package:flutter_senior_project/features/diary/view/view_diary/widget/main_header_logo.dart';
import 'package:flutter_senior_project/features/diary/view/view_diary/widget/skeleton_card.dart';
import 'package:flutter_senior_project/features/diary/vm/fetch_post_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/common/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/common/utils/transition_animation.dart';
import 'package:flutter_senior_project/features/common/widget/custom_animate_gradient.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
import 'package:flutter_senior_project/features/diary/view/add_diary/add_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/diary/view/view_diary/widget/diary_card.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ViewMyDiaryScreen extends StatefulHookConsumerWidget {
  const ViewMyDiaryScreen({super.key});

  @override
  ViewMyDiaryScreenState createState() => ViewMyDiaryScreenState();
}

class ViewMyDiaryScreenState extends ConsumerState<ViewMyDiaryScreen> {
  void onGearsTap(
    BuildContext context,
    ValueNotifier<double> opacity,
  ) {
    transitionAnimationPushNamed(
      context: context,
      opacity: opacity,
      routeName: RouteNames.settings,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(fetchPostsViewModelProvider.notifier).fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(showcaseVMProvider);
    final opacity = useState(1.0);
    final postsState = ref.watch(fetchPostsViewModelProvider);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: opacity.value,
      child: DraggableHome(
        headerBottomBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                ShowCaseWidget.of(context).startShowCase(
                  [
                    vm.keyOne,
                    vm.keyTwo,
                    vm.keyThree,
                  ],
                );
              },
              child: const FaIcon(
                FontAwesomeIcons.solidCircleQuestion,
                color: Colors.white,
              ),
            ),
            Gear(
              ref: ref,
              onTap: () => onGearsTap(context, opacity),
            ),
          ],
        ),
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
        headerWidget: const MainHeaderLogo(),
        body: [
          postsState.when(
            data: (posts) {
              final opacity = useState(0.0);

              useEffect(() {
                Future.delayed(const Duration(milliseconds: 200), () {
                  opacity.value = 1.0;
                });
                return null;
              }, []);

              return AnimatedOpacity(
                opacity: opacity.value,
                duration: const Duration(milliseconds: 300),
                child: posts.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(200),
                          CustomShader(
                            child: Text(
                              "...일기가 없어요!",
                              style: CustomTextTheme.whiteMedium,
                            ),
                          ),
                        ],
                      )
                    : Diaries(posts: posts),
              );
            },
            loading: () => const SkeletonLoader(),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
