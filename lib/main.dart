import 'package:flutter/material.dart';
import 'package:immo_manager/home/flashScreen.dart';
import 'package:immo_manager/authentifications/login.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WimmoAgent',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

