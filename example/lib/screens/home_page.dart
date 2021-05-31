import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animations.dart';
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

  GlobalKey<ScaffoldState> keyScaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: keyScaffold,
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Quds UI Kit'),
        ),
        body: Container(
          child: Center(
            child: QudsAutoAnimatedBlur(
                child: QudsScalablePressable(
                    scaleWhenTapDown: true,
                    scaleWhenMouseEnter: true,
                    duration: const Duration(milliseconds: 150),
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
                    ))),
          ),
        ));
  }
}
