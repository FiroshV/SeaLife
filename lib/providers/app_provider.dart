import 'package:flutter/material.dart';
import 'package:sealife/utils/hero_images.dart';

class AppProvider extends ChangeNotifier {
  late int pageIndex = 0;
  final pageViewController = PageController(
    initialPage: heroImages.length * 9999,
  );

  void setPageIndex(int index) {
    pageIndex = index % heroImages.length;
    notifyListeners();
  }

  void changePage(int index) {
    final pos = ((pageViewController.page ?? 0) / heroImages.length).floor() *
        heroImages.length;

    pageIndex = index % heroImages.length;
    pageViewController.animateToPage(pos + index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }
}
