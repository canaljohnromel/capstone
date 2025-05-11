import 'package:capstone/dashboard_screen.dart';
import 'package:capstone/login_screen.dart';
import 'package:flutter/material.dart';

class PinesvilleLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}