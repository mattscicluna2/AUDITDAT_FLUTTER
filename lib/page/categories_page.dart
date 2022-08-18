import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/interface/bottom_nav_settings.dart';
import 'package:auditdat/layout/base_page.dart';
import 'package:auditdat/layout/tabular_page.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return TabularPage(
      bottomNavSettings: BottomNavSettings(
        tabItems: [
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Ongoing Inspections',
          ),
        ],
        pages: [
          Center(
            child: Icon(
              Icons.call,
              size: 150,
            ),
          ),
          Icon(
            Icons.camera,
            size: 150,
          ),
        ]
      ),
    );
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

