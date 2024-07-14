import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/common/utils/is_dark_mode.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoaderCard extends ConsumerWidget {
  const SkeletonLoaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Skeleton.leaf(
        enabled: true,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              24,
            ),
            color: isDarkMode(ref) ? Colors.black : Colors.grey.shade300,
          ),
          height: 110,
          child: const Row(),
        ),
      ),
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(),
      child: ListView.separated(
        separatorBuilder: (context, index) => const Gap(20),
        padding: const EdgeInsets.only(top: 10, bottom: 100),
        itemCount: 7,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const SkeletonLoaderCard();
        },
      ),
    );
  }
}
