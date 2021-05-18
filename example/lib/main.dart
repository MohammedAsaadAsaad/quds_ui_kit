import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quds UI Kit Example',
      theme: ThemeData(brightness: Brightness.light),
      home: SplashScreen(),
    );
  }
}
