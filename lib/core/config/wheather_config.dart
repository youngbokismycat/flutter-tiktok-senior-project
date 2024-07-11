import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

const CloudWidget bigCloudWidget = CloudWidget(
  cloudConfig: CloudConfig(
    y: -50,
  ),
);

const CloudWidget smallAwayCloudWidget = CloudWidget(
  cloudConfig: CloudConfig(
    size: 160,
    color: Color(0xa8fafafa),
    x: 1500,
    y: 97,
    scaleBegin: 1,
    scaleEnd: 1.1,
    scaleCurve: Curves.linear,
    slideX: 20,
    slideY: 4,
    slideDurMill: 2000,
    slideCurve: Curves.linear,
  ),
);
const CloudWidget smallAwayCloudReverseWidget = CloudWidget(
  cloudConfig: CloudConfig(
    size: 160,
    color: Color(0xa8fafafa),
    x: 1500,
    y: 0,
    scaleBegin: 1,
    scaleEnd: 1.1,
    scaleCurve: Curves.linear,
    slideX: 20,
    slideY: 4,
    slideDurMill: 2000,
    slideCurve: Curves.linear,
  ),
);
const CloudWidget smallCloudWidget = CloudWidget(
  cloudConfig: CloudConfig(
    size: 160,
    color: Color(0xa8fafafa),
    x: 240,
    y: 30,
    scaleBegin: 1,
    scaleEnd: 1.1,
    scaleCurve: Curves.linear,
    slideX: 20,
    slideY: 4,
    slideDurMill: 2000,
    slideCurve: Curves.linear,
  ),
);

abstract class WeatherConfiguration {
  static WrapperScene sunnyMorning = const WrapperScene(
    colors: [
      Color(0xff303f9f),
      Color(0xff1e88e5),
    ],
    children: [
      SunWidget(),
      CloudWidget(
        cloudConfig: CloudConfig(
          y: -30,
        ),
      ),
      CloudWidget(
        cloudConfig: CloudConfig(
          size: 160,
          color: Color(0xa8fafafa),
          x: 1500,
          y: 97,
          scaleBegin: 1,
          scaleEnd: 1.1,
          scaleCurve: Curves.linear,
          slideX: 20,
          slideY: 4,
          slideDurMill: 2000,
          slideCurve: Curves.linear,
        ),
      ),
    ],
  );

  static Transform sunnyEvening = Transform.flip(
    flipX: true,
    child: const WrapperScene(
      colors: [
        Color(0xFFf46842), // Warm orange for evening sky
        Color(0xFFd99491), // Deep red for sunset effect
      ],
      children: [
        SunWidget(
          sunConfig: SunConfig(),
        ),
        bigCloudWidget,
        smallAwayCloudReverseWidget,
      ],
    ),
  );

  static WrapperScene rainyMorning = const WrapperScene(
    colors: [
      Color(0xffB0BEC5), // Light grey for overcast sky
      Color(0xffCFD8DC), // Pale grey for rain effect
    ],
    children: [
      RainWidget(
        rainConfig: RainConfig(
          areaYStart: 170,
        ),
      ),
      bigCloudWidget,
      smallCloudWidget,
    ],
  );

  static WrapperScene rainyEvening = WrapperScene(
    colors: const [
      Color(0xff455A64), // Dark grey for evening rain sky
      Color(0xff607D8B), // Slightly lighter grey for rain effect
    ],
    children: [
      const RainWidget(
        rainConfig: RainConfig(
          areaYStart: 100,
        ),
      ),
      const CloudWidget(
        cloudConfig: CloudConfig(
          size: 250.0,
          y: -50,
          color: Colors.grey,
          icon: Icons.cloud,
        ),
      ),
      CloudWidget(
        cloudConfig: CloudConfig(
          scaleEnd: 1.1,
          slideX: 20,
          slideY: 4,
          size: 150.0,
          y: -30,
          x: 50,
          color: Colors.grey.shade600,
          icon: Icons.cloud,
        ),
      ),
    ],
  );

  static WrapperScene cloudyDay = const WrapperScene(
    colors: [
      Color(0xff90A4AE),
      Color(0xffB0BEC5),
    ],
    children: [
      CloudWidget(
        cloudConfig: CloudConfig(
          size: 300.0,
          color: Colors.grey,
          icon: Icons.cloud,
          x: 0.0,
          y: 0.2,
          scaleBegin: 1.0,
          scaleEnd: 1.2,
          scaleCurve: Curves.easeInOut,
          slideX: 0.0,
          slideY: 0.0,
          slideDurMill: 15000,
          slideCurve: Curves.easeInOut,
        ),
      ),
    ],
  );

  static List<Widget> get allScenes => [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            24,
          ),
          child: sunnyMorning,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            24,
          ),
          child: sunnyEvening,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            24,
          ),
          child: rainyMorning,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(
            24,
          ),
          child: rainyEvening,
        ),
      ];
}
