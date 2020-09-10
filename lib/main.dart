import 'package:flutter/material.dart';
import 'package:immo_manager/flashScreen.dart';
import 'package:immo_manager/login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [ DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown, ]
    );
    return MaterialApp(
      title: 'ImmoManager',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

