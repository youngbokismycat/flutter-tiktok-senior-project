import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:go_router/go_router.dart';

void transitionAnimationPushNamed(
    {required BuildContext context,
    required ValueNotifier<double> opacity,
    required String routeName}) async {
  opacity.value = 0.0;
  await Future.delayed(
    const Duration(
      milliseconds: 300,
    ),
  );
  await context.pushNamed(
    routeName,
  );
  opacity.value = 1.0;
}

void transitionAnimationPushNamedAndReplace(
    {required BuildContext context,
    required ValueNotifier<double> opacity,
    required String routeName}) async {
  opacity.value = 0.0;
  await Future.delayed(
    const Duration(
      milliseconds: 300,
    ),
  );
  context.pushReplacementNamed(
    routeName,
  );
  await Future.delayed(
    const Duration(
      milliseconds: 400,
    ),
  );
  opacity.value = 1.0;
}

void transitionAnimationPop({
  required BuildContext context,
  required ValueNotifier<double> opacity,
}) async {
  opacity.value = 0.0;
  await Future.delayed(
    const Duration(
      milliseconds: 300,
    ),
  );
  context.pop(
    RouteNames.signUp,
  );
  await Future.delayed(
    const Duration(
      milliseconds: 400,
    ),
  );
  opacity.value = 1.0;
}

void transitionAnimation({
  required ValueNotifier<double> opacity,
}) async {
  opacity.value = 0.0;
  await Future.delayed(
    const Duration(
      milliseconds: 300,
    ),
  );
  opacity.value = 1.0;
}
