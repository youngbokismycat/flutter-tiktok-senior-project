import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
          gradient: const LinearGradient(
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
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 24,
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
