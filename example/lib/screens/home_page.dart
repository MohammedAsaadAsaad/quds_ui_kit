import 'package:flutter/material.dart';
import 'drawer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showFirstIcon = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Quds UI Kit'),
      ),
      body: Container(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back,
              size: 70,
            ),
            Text(
              'Open Side Drawer',
              style: TextStyle(fontSize: 24),
            )
          ],
        )),
      ),
    );
  }
}
