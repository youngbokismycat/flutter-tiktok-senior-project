import 'dart:io';

import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
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
    final opacity = useState(1.0);
    final postsState = ref.watch(fetchPostsViewModelProvider);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: opacity.value,
      child: DraggableHome(
        headerBottomBar: Gear(
          ref: ref,
          onTap: () => onGearsTap(context, opacity),
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
        headerWidget: const HeaderWidget(),
        body: [
          postsState.when(
            data: (posts) => Diaries(posts: posts),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}

class Gear extends StatelessWidget {
  final Function() onTap;
  const Gear({
    super.key,
    required this.onTap,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Align(
        alignment: Alignment.centerRight,
        child: FaIcon(
          FontAwesomeIcons.gear,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Diaries extends StatelessWidget {
  const Diaries({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Gap(30),
      itemBuilder: (context, index) =>
          DiaryCard(post: posts[index], index: index),
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
