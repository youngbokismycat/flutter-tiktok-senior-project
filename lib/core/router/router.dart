import 'package:flutter_senior_project/core/route_names.dart';
import 'package:flutter_senior_project/features/authentication/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: RouteNames.signUpUrl,
    routes: [
      GoRoute(
        name: RouteNames.signUp,
        path: RouteNames.signUpUrl,
        builder: (context, state) => const SignupScreen(),
      )
    ],
  ),
);
