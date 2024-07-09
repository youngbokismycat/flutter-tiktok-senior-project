import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/view/signin_screen.dart';
import 'package:flutter_senior_project/features/authentication/view/signup_screen.dart';
import 'package:flutter_senior_project/features/onboarding/view/onboarding_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:flutter_senior_project/features/home/view/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: RouteNames.homeUrl,
      routes: [
        GoRoute(
          name: RouteNames.logoSplash,
          path: RouteNames.logoSplashUrl,
          pageBuilder: (context, state) => transitionPage(
            state,
            SplashScreen(action: state.extra as String?),
          ),
        ),
        GoRoute(
          name: RouteNames.signIn,
          path: RouteNames.signInUrl,
          pageBuilder: (context, state) => transitionPage(
            state,
            const SigninScreen(),
          ),
        ),
        GoRoute(
          path: RouteNames.signUpUrl,
          name: RouteNames.signUp,
          pageBuilder: (context, state) => transitionPage(
            state,
            const SignupScreen(),
          ),
        ),
        GoRoute(
          name: RouteNames.onboarding,
          path: RouteNames.onboardingUrl,
          pageBuilder: (context, state) => transitionPage(
            state,
            const OnboardingScreen(),
          ),
        ),
        GoRoute(
          name: RouteNames.home,
          path: RouteNames.homeUrl,
          pageBuilder: (context, state) =>
              transitionPage(state, const HomeScreen()),
        ),
      ],
    );
  },
);

CustomTransitionPage<dynamic> transitionPage(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
