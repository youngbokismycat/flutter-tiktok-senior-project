import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart'; // Import the is_dark_mode utility
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _colorAnimation;
  late final ColorTween _colorTween;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _colorTween = ColorTween(
        begin: FlexColor.aquaBlueDarkPrimary,
        end: FlexColor.redWineDarkPrimary);
    _colorAnimation = _colorTween.animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimations();
    });
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        _opacity = 0.0;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        context.go(RouteNames.signInUrl);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 500),
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blue, _colorAnimation.value!],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: const Text(
                  '물들다',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
