import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/signup_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: RouteNames.logoSplashUrl,
    routes: [
      GoRoute(
        name: RouteNames.logoSplash,
        path: RouteNames.logoSplashUrl,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.signUp,
        path: RouteNames.signUpUrl,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(
              milliseconds: 250,
            ),
            key: state.pageKey,
            child: const SignupScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      )
    ],
  ),
);
