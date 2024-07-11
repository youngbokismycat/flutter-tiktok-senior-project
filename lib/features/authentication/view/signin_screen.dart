import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/core/utils/transition_animation.dart';
import 'package:flutter_senior_project/features/authentication/view/widget/custom_login_button.dart';
import 'package:flutter_senior_project/features/authentication/vm/auth_vm.dart';
import 'package:flutter_senior_project/features/common/widget/auth_text_form_field.dart';
import 'package:flutter_senior_project/features/common/widget/logo_gradient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_senior_project/features/common/widget/default_padding.dart';
import 'package:gap/gap.dart';

class SigninScreen extends HookConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final opacity = useState(1.0);
    final formKey = useState(GlobalKey<FormState>());

    void signIn(GlobalKey<FormState> formKey, ValueNotifier<bool> isLoading,
        BuildContext context) async {
      if (formKey.currentState?.validate() ?? false) {
        isLoading.value = true;
        FocusScope.of(context).unfocus();
        await ref.read(authViewModelProvider.notifier).signIn(
            emailController.text, passwordController.text, context, opacity);
        isLoading.value = false;
      }
    }

    void onSignupTap(BuildContext context) async {
      transitionAnimationPushNamed(
        context: context,
        opacity: opacity,
        routeName: RouteNames.signUp,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedOpacity(
          duration: const Duration(
            milliseconds: 300,
          ),
          opacity: opacity.value,
          child: SafeArea(
            child: DefaultPadding(
              child: Form(
                key: formKey.value,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) => gradient.createShader(
                            bounds,
                          ),
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
                            'LOGIN',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Gap(5),
                          CustomTextFormField(
                            controller: emailController,
                            labelText: '이메일',
                          ),
                          const Gap(10),
                          CustomTextFormField(
                            controller: passwordController,
                            obscureText: true,
                            labelText: '비밀번호',
                          ),
                          const Gap(20),
                          CustomLoginButton(
                            text: '로그인',
                            textColor: Colors.white,
                            onPressed: () => signIn(
                              formKey.value,
                              isLoading,
                              context,
                            ),
                            isLoading: isLoading.value,
                          ),
                          const Gap(5),
                          const Opacity(
                            opacity: 0.5,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '비밀번호를 잊어먹으셨나요?',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => onSignupTap(context),
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '계정이 없다면?',
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
    );
  }
}
