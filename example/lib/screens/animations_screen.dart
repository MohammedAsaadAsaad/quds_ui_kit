import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class AnimationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AnimationsScreen> {
  bool showStartIcon = true;
  int counter = 1;
  bool autoFlip = false;
  late Timer autoFlipTimer;

  @override
  void initState() {
    super.initState();
    autoFlipTimer = Timer.periodic(Duration(milliseconds: 1000), (tmr) {
      if (autoFlip) _toggleIcons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(actions: [
        Checkbox(
            value: autoFlip,
            onChanged: (v) => setState(() => autoFlip = v ?? false)),
        QudsAnimatedText(autoFlip ? 'Auto' : 'Manual'),
        SizedBox(width: 10),
        IconButton(
            icon: Icon(showStartIcon ? Icons.filter_1 : Icons.filter_2),
            onPressed: _toggleIcons),
        QudsAnimatedCombinedIconsButton(
            startIcon: Icons.filter_1,
            endIcon: Icons.filter_2,
            showStartIcon: showStartIcon,
            onPressed: _toggleIcons)
      ], title: Text('Animations')),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ..._buildAnimatedTexts(),
          ..._buildIconWithShadow(),
          ..._buildAnimatedIcons()
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedTexts() {
    return [
      Text('Animated Text'),
      QudsAnimatedText(
        counter.toString(),
        duration: Duration(milliseconds: 200),
        style: TextStyle(fontSize: 30),
      ),
      Divider(),
      Text('Animated Counter'),
      QudsAnimatedCounter(
        counter,
        duration: Duration(milliseconds: 200),
        length: 4,
        style: TextStyle(fontSize: 30),
      ),
      Divider(),
    ];
  }

  List<Widget> _buildIconWithShadow() {
    return [
      Text('Icon with shadow'),
      Row(children: [
        QudsIconWithShadow(
          iconData: Icons.add,
          size: 50,
          // offset: Offset(-5, -5),
        ),
        Container(
            color: Colors.blue,
            padding: EdgeInsets.all(5),
            child: QudsIconWithShadow(
              color: Colors.white,
              shadowColor: Colors.black38,
              offset: Offset(4, 5),
              iconData: Icons.add,
              size: 50,
              // offset: Offset(-5, -5),
            ))
      ]),
      Divider(),
    ];
  }

  List<Widget> _buildAnimatedIcons() {
    return [
      Row(children: [
        Text('Animated Icons'),
        SizedBox(
          width: 10,
        ),
        QudsAnimatedText(
          showStartIcon ? 'Playing' : 'Paused',
          style: TextStyle(fontSize: 50),
        )
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIcons(
            // textDirection: TextDirection.rtl,
            duration: Duration(milliseconds: 250),
            curve: Curves.ease,
            iconSize: 50,
            startIcon: Icons.arrow_forward,
            // startIconColor: Colors.white,
            endIcon: Icons.menu,
            endIconColor: Colors.yellow,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedIcon(
            iconData: AnimatedIcons.arrow_menu,
            textDirection: TextDirection.rtl,
            showStartIcon: showStartIcon,
            iconSize: 50,
            duration: Duration(milliseconds: 250),
            // startIconColor: Colors.white,
            endIconColor: Colors.yellow,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIcons(
            startIcon: Icons.add,
            endIcon: Icons.event,
            startIconColor: Colors.yellow,
            endIconColor: Colors.red,
            showStartIcon: showStartIcon,
            iconSize: 50,
          ),
          QudsAnimatedIcon(
            iconData: AnimatedIcons.add_event,
            startIconColor: Colors.yellow,
            endIconColor: Colors.red,
            showStartIcon: showStartIcon,
            iconSize: 50,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIcons(
            iconSize: 100,
            startIcon: Icons.play_arrow,
            endIcon: Icons.pause,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedIcon(
            iconSize: 100,
            iconData: AnimatedIcons.play_pause,
            showStartIcon: showStartIcon,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIcons(
            iconSize: 30,
            startIcon: Icons.arrow_back,
            endIcon: Icons.arrow_forward,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIcons(
            iconSize: 30,
            startIcon: Icons.arrow_upward,
            endIcon: Icons.arrow_downward,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIcons(
            iconSize: 30,
            startIcon: CupertinoIcons.app,
            endIcon: CupertinoIcons.circle,
            showStartIcon: showStartIcon,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIcons(
            endIconColor: Colors.green,
            iconSize: 70,
            startIcon: Icons.event,
            endIcon: Icons.event_available,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIcons(
            endIconColor: Colors.green,
            iconSize: 70,
            withRotation: false,
            startIcon: Icons.event,
            endIcon: Icons.event_available,
            showStartIcon: showStartIcon,
          ),
        ],
      ),
      QudsAnimatedCombinedIcons(
        iconSize: 50,
        startIcon: Icons.accessible,
        endIcon: Icons.accessibility_new,
        showStartIcon: showStartIcon,
      ),
    ];
  }

  void _toggleIcons() {
    setState(() {
      counter++;
      showStartIcon = !showStartIcon;
    });
  }

  @override
  void dispose() {
    super.dispose();
    autoFlipTimer.cancel();
  }
}
