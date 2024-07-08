import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/core/utils/show_firebase_error.dart';
import 'package:flutter_senior_project/features/authentication/repo/auth_repo.dart';
import 'package:go_router/go_router.dart';

class AuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AsyncValue.data(null)) {
    _authRepository.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    state = await AsyncValue.guard(() async {
      await _authRepository.signUpWithEmailAndPassword(email, password);
      return _authRepository.currentUser;
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(RouteNames.logoSplash, extra: 'signUp');
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    state = await AsyncValue.guard(() async {
      await _authRepository.signInWithEmailAndPassword(email, password);
      return _authRepository.currentUser;
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(RouteNames.logoSplash, extra: 'signIn');
    }
  }

  Future<void> signOut() async {
    state = await AsyncValue.guard(() async {
      await _authRepository.signOut();
      return null;
    });
  }
}

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthViewModel(authRepository);
});
