import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/repo/auth_repo.dart';
import 'package:flutter_senior_project/features/authentication/view/signin_screen.dart';
import 'package:flutter_senior_project/features/authentication/view/signup_screen.dart';
import 'package:flutter_senior_project/features/diary/model/post_model.dart';
import 'package:flutter_senior_project/features/diary/view/detail_diary/detail_diary_card_screen.dart';
import 'package:flutter_senior_project/features/onboarding/onboarding_screen.dart';
import 'package:flutter_senior_project/features/settings/settings_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:flutter_senior_project/features/main_navigation/view/main_navigation_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    ref.watch(authState);

    return GoRouter(
      initialLocation: RouteNames.logoSplashUrl,
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepositoryProvider).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != RouteNames.signInUrl &&
              state.matchedLocation != RouteNames.signUpUrl &&
              state.matchedLocation != RouteNames.logoSplashUrl) {
            return RouteNames.logoSplashUrl;
          }
        }
        return null;
      },
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
          pageBuilder: (context, state) => transitionPage(
            state,
            MainNavigation(),
          ),
        ),
        GoRoute(
            name: RouteNames.detailDiary,
            path: RouteNames.detailDiaryUrl,
            pageBuilder: (context, state) {
              final post = state.extra as Post;
              return transitionPage(
                state,
                DetailDiaryCardScreen(
                  post: post,
                ),
              );
            }),
        GoRoute(
          name: RouteNames.settings,
          path: RouteNames.settingsUrl,
          pageBuilder: (context, state) => transitionPage(
            state,
            const SettingsScreen(),
          ),
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
