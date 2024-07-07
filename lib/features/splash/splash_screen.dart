import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_senior_project/core/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final opacity = useState(0.0);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));
    final colorTween = useMemoized(
        () => ColorTween(
            begin: FlexColor.dashBlueDarkPrimary,
            end: FlexColor.redWineDarkPrimary),
        []);
    final colorAnimation = colorTween.animate(animationController);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        opacity.value = 1.0;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        animationController.forward();
      });

      final timer = Future.delayed(const Duration(milliseconds: 2000), () {
        opacity.value = 0.0;
        Future.delayed(const Duration(milliseconds: 500), () {
          context.go(RouteNames.signInUrl);
        });
      });

      return () {
        timer.ignore();
      };
    }, [animationController]);

    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opacity.value,
          duration: const Duration(milliseconds: 500),
          child: AnimatedBuilder(
            animation: colorAnimation,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.blue, colorAnimation.value!],
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
