import 'package:flutter/material.dart';

class BottomNavSettings {
  late List<BottomNavigationBarItem> tabItems;
  late List<Widget> pages;
  late int selectedIndex;

  BottomNavSettings(
      {required this.tabItems, required this.pages, required this.selectedIndex});
}
