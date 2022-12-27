import 'package:auditdat/interface/bottom_nav_settings.dart';
import 'package:auditdat/layout/tabular_page.dart';
import 'package:auditdat/page/categories_page.dart';
import 'package:auditdat/page/ongoing_inspections_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return TabularPage(
      bottomNavSettings: BottomNavSettings(selectedIndex: widget.selectedIndex, tabItems: [
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'Templates',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'Ongoing Inspections',
        ),
      ], pages: [
        CategoriesPage(),
        OngoingInspectionsPage()
      ]),
    );
  }
}
