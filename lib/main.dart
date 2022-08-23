import 'dart:io';

import 'package:auditdat/changenotifier/model/app_settings.dart';
import 'package:auditdat/constants/color_constants.dart';
import 'package:auditdat/constants/material_color_constants.dart';
import 'package:auditdat/page/home_page.dart';
import 'package:auditdat/page/login_page.dart';
import 'package:auditdat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'page/notes_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  stderr.writeln("This log is using stderr");

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppSettings(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: MaterialColor(
              ColorConstants.primary.value, MaterialColorConstants.primary),
        ),
        home: FutureBuilder(
          future: AuthService.instance.getUser(),
          builder: (_, snapshot) {
            print(snapshot);
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        ),
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      );
}
