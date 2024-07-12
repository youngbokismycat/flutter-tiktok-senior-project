import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoaderCard extends StatelessWidget {
  const SkeletonLoaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Skeleton.leaf(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              24,
            ),
            color: Colors.grey.shade300,
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
