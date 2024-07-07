import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/features/authentication/view/signin_screen.dart';
import 'package:flutter_senior_project/features/home/home_screen.dart';
import 'package:flutter_senior_project/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: RouteNames.logoSplashUrl,
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
        builder: (context, state) => const SigninScreen(),
      ),
    ],
  ),
);
