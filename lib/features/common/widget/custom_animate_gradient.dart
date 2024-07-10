import 'package:animate_gradient/animate_gradient.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomAnimateGradient extends StatelessWidget {
  const CustomAnimateGradient({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimateGradient(
      duration: const Duration(seconds: 20),
      primaryBeginGeometry: const AlignmentDirectional(0, 3),
      primaryEndGeometry: const AlignmentDirectional(0, 2),
      secondaryBeginGeometry: const AlignmentDirectional(2, 0),
      secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
      textDirectionForGeometry: TextDirection.rtl,
      primaryColors: const [
        FlexColor.blueDarkPrimary,
        FlexColor.redWineDarkPrimary,
      ],
      secondaryColors: const [
        FlexColor.redWineDarkPrimary,
        FlexColor.blueDarkPrimary,
      ],
      child: child,
    );
  }
}
