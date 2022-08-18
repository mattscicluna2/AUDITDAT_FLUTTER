import 'dart:io';

import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/constants/material_color_constants.dart';
import 'package:auditdat/page/categories_page.dart';
import 'package:auditdat/page/login_page.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'page/notes_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  stderr.writeln("This log is using stderr");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(ColorConstants.primary.value, MaterialColorConstants.primary),
      ),
      home: FutureBuilder(
        future: AuthService.instance.getUser(),
        builder: (_, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return CategoriesPage();
          } else {
            return LoginPage();
          }
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => CategoriesPage(),
      },
    );



  //
  // Widget build(BuildContext context) => MaterialApp(
  //   theme: ThemeData(
  //     primarySwatch: MaterialColor(ColorConstants.primary.value, MaterialColorConstants.primary),
  //   ),
  //   debugShowCheckedModeBanner: false,
  //   title: title,
  //   themeMode: ThemeMode.dark,
  //   theme: ThemeData(
  //     primaryColor: Colors.black,
  //     scaffoldBackgroundColor: Colors.blueGrey.shade900,
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: Colors.transparent,
  //       elevation: 0,
  //     ),
  //   ),
  //   home: LoginPage(),
  // );
}