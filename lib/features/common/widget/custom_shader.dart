import 'package:flutter/material.dart';
import 'package:flutter_senior_project/features/common/widget/logo_gradient.dart';

class CustomShader extends StatelessWidget {
  final Widget child;
  const CustomShader({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: child,
    );
  }
}
