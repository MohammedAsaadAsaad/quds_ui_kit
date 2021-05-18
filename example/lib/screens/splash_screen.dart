import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QudsSplashView(
        showIndicator: true,
        onCompleted: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(),
            )),
      ),
    );
  }
}
