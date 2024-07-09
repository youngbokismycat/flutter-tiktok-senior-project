import 'package:animate_gradient/animate_gradient.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:faker/faker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_senior_project/core/utils/is_dark_mode.dart';
import 'package:flutter_senior_project/features/add/add_my_dairy_screen.dart';
import 'package:flutter_senior_project/features/common/widget/custom_shader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewMyDairyScreen extends ConsumerStatefulWidget {
  const ViewMyDairyScreen({super.key});

  @override
  ViewMyDairyScreenState createState() => ViewMyDairyScreenState();
}

class ViewMyDairyScreenState extends ConsumerState<ViewMyDairyScreen> {
  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      backgroundColor: isDarkMode(ref) ? darkModeColor : Colors.white,
      title: const CustomShader(
        child: Text(
          "물들다",
        ),
      ),
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        listView(),
      ],
    );
  }

  Row headerBottomBarWidget() {
    return const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget headerWidget(BuildContext context) {
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
      child: Container(
        child: Center(
          child: Text(
            "물들다",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text("$index"),
          ),
          title: const Text("Title"),
          subtitle: const Text("Subtitle"),
        ),
      ),
    );
  }
}
