import 'package:auditdat/interface/bottom_nav_settings.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:flutter/material.dart';

class TabularPage extends StatefulWidget {
  final BottomNavSettings bottomNavSettings;

  const TabularPage({ required this.bottomNavSettings, Key? key})
      : assert(bottomNavSettings != null),
        super(key: key);

  @override
  State<TabularPage> createState() => _TabularPageState();
}

class _TabularPageState extends State<TabularPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BasePage(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavItemTapped,
          items: widget.bottomNavSettings.tabItems,
        ),
        body: widget.bottomNavSettings.pages.elementAt(_selectedIndex),
    );
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
