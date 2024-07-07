import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final formKey = useState(GlobalKey<FormState>());

    void signIn() async {
      if (!formKey.value.currentState!.validate()) {
        return;
      }

      final email = emailController.text;
      final password = passwordController.text;

      isLoading.value = true;

      try {
        // Implement your sign-in logic here
        // For example, using Firebase Authentication:
        // await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        // On success, navigate to the home screen
        // context.go(RouteNames.homeUrl);
      } catch (e) {
        // Handle error
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: DefaultPadding(
          child: Form(
            key: formKey.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: '이메일'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: '비밀번호'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '비밀번호를 입력해주세요.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomLoginButton(
                  text: '로그인',
                  textColor: Colors.white,
                  onPressed: signIn,
                  isLoading: isLoading.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomLoginButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomLoginButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          gradient: isLoading
              ? null
              : const LinearGradient(
                  colors: [
                    FlexColor.aquaBlueDarkPrimary,
                    FlexColor.redWineDarkPrimary,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
          color: isLoading ? Colors.grey : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

class GradientOutlineInputBorder extends OutlineInputBorder {
  final Gradient gradient;

  const GradientOutlineInputBorder({
    super.borderRadius = BorderRadius.zero,
    this.gradient = const LinearGradient(
      colors: [Colors.blue, Colors.red],
    ),
  });

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final borderRect = rect.deflate(borderSide.width / 2.0);
    canvas.drawRRect(borderRadius.toRRect(borderRect), paint);
  }
}
