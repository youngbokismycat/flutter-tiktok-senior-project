import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/features/common/utils/transition_animation.dart';
import 'package:flutter_senior_project/features/authentication/view/widget/custom_login_button.dart';
import 'package:flutter_senior_project/features/authentication/vm/auth_vm.dart';
import 'package:flutter_senior_project/features/authentication/view/widget/auth_text_form_field.dart';
import 'package:flutter_senior_project/features/common/widget/logo_gradient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_senior_project/features/common/widget/default_padding.dart';
import 'package:gap/gap.dart';

class SignupScreen extends StatefulHookConsumerWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final opacity = useState(1.0);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmController = useTextEditingController();
    final isLoading = useState(false);
    final formKey = useState(GlobalKey<FormState>());
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 200),
      initialValue: 1.0,
      upperBound: 1.0,
      lowerBound: 0,
    );

    void signUp(GlobalKey<FormState> formKey, ValueNotifier<bool> isLoading,
        BuildContext context) async {
      if (formKey.currentState?.validate() ?? false) {
        isLoading.value = true;
        FocusScope.of(context).unfocus();
        await ref.read(authViewModelProvider.notifier).signUp(
            emailController.text, passwordController.text, context, opacity);
        isLoading.value = false;
      }
    }

    void onSigninTap(BuildContext context) {
      transitionAnimationPop(context: context, opacity: opacity);
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: animationController,
              child: DefaultPadding(
                child: Form(
                  key: formKey.value,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) =>
                                gradient.createShader(bounds),
                            child: const Text(
                              '물들다',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SIGNUP',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Gap(5),
                            CustomTextFormField(
                              controller: emailController,
                              labelText: '이메일',
                              validator: (value) {
                                final emailRegExp =
                                    RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                if (value == null ||
                                    value.isEmpty ||
                                    !emailRegExp.hasMatch(value)) {
                                  return '유효한 이메일을 입력해주세요.';
                                }
                                return null;
                              },
                            ),
                            const Gap(10),
                            CustomTextFormField(
                              controller: passwordController,
                              labelText: '비밀번호',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '비밀번호를 입력해주세요.';
                                } else if (value.length < 8 ||
                                    value.length > 20) {
                                  return '비밀번호는 8자 이상 20자 이하이어야 합니다.';
                                }
                                return null;
                              },
                            ),
                            const Gap(10),
                            CustomTextFormField(
                              controller: passwordConfirmController,
                              labelText: '비밀번호 확인',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '비밀번호 확인을 입력해주세요.';
                                } else if (value != passwordController.text) {
                                  return '비밀번호가 일치하지 않습니다.';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            ValueListenableBuilder<bool>(
                              valueListenable: isLoading,
                              builder: (context, loading, child) =>
                                  CustomLoginButton(
                                text: '회원가입',
                                textColor: Colors.white,
                                onPressed: () =>
                                    signUp(formKey.value, isLoading, context),
                                isLoading: isLoading.value,
                              ),
                            ),
                            const Gap(5),
                            const Opacity(
                              opacity: 0.5,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '이메일이 없으신가요?',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => onSigninTap(context),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '계정이 이미 있다면?',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
