import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/view/signin_screen.dart';
import 'package:flutter_senior_project/features/authentication/view/signup_screen.dart';
import 'package:flutter_senior_project/features/onboarding/view/onboarding_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:flutter_senior_project/features/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final routerProvider = Provider<GoRouter>(
  (ref) {
    final authState = ref.watch(authStateProvider);

    return GoRouter(
      initialLocation: RouteNames.logoSplashUrl,
      routes: [
        GoRoute(
          name: RouteNames.logoSplash,
          path: RouteNames.logoSplashUrl,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const SplashScreen(),
            );
          },
        ),
        GoRoute(
          name: RouteNames.signIn,
          path: RouteNames.signInUrl,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SigninScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: RouteNames.signUpUrl,
          name: RouteNames.signUp,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          name: RouteNames.onboarding,
          path: RouteNames.onboardingUrl,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const OnboardingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          name: RouteNames.home,
          path: RouteNames.homeUrl,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
      ],
    );
  },
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }
}
