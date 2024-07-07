import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/home/home_screen.dart';

import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: RouteNames.signInUrl,
    routes: [
      GoRoute(
        name: RouteNames.logoSplash,
        path: RouteNames.logoSplashUrl,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RouteNames.homeUrl,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: RouteNames.signIn,
        path: RouteNames.signInUrl,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        name: RouteNames.verifyEmail,
        path: RouteNames.verifyEmailUrl,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final isLoggingIn = state.matchedLocation == RouteNames.signInUrl ||
          state.matchedLocation == RouteNames.signUpUrl;

      if (!isLoggedIn && !isLoggingIn) {
        return RouteNames.logoSplashUrl;
      } else if (isLoggedIn &&
          (isLoggingIn || state.matchedLocation == RouteNames.logoSplashUrl)) {
        return RouteNames.homeUrl;
      }
      return null;
    },
  ),
);
