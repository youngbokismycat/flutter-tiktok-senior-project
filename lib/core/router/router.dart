import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/view/signin_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:flutter_senior_project/features/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: RouteNames.logoSplashUrl,
    routes: [
      GoRoute(
        name: RouteNames.logoSplash,
        path: RouteNames.logoSplashUrl,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RouteNames.homeUrl,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.signIn,
        path: RouteNames.signInUrl,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SigninScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    ],
  ),
);
