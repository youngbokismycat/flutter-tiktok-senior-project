import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShowcaseViewModel extends ChangeNotifier {
  final GlobalKey keyOne = GlobalKey();
  final GlobalKey keyTwo = GlobalKey();
  final GlobalKey keyThree = GlobalKey();
}

final showcaseVMProvider = ChangeNotifierProvider((_) => ShowcaseViewModel());
