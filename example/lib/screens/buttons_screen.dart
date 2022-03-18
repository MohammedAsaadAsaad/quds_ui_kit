import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class ButtonsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ButtonsScreen> {
  bool showStartIcon = true;
  int counter = 1;
  bool autoFlip = false;
  late Timer autoFlipTimer;

  @override
  void initState() {
    super.initState();
    autoFlipTimer = Timer.periodic(Duration(milliseconds: 1000), (tmr) {
      if (autoFlip) _toggle();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Scaffold(
      body: _buildBody(),
      appBar: AppBar(actions: [
        Checkbox(
            value: autoFlip,
            onChanged: (v) => setState(() => autoFlip = v ?? false)),
        QudsAnimatedText(autoFlip ? 'Auto' : 'Manual'),
        SizedBox(width: 10),
        IconButton(
            icon: Icon(showStartIcon ? Icons.filter_1 : Icons.filter_2),
            onPressed: _toggle),
        QudsAnimatedCombinedIconsButton(
            startIcon: Icons.filter_1,
            endIcon: Icons.filter_2,
            showStartIcon: showStartIcon,
            onPressed: _toggle)
      ], title: Text('Buttons')),
    );

    return result;
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[..._buildCheckBoxes(), ..._buildAnimatedIcons()],
      ),
    );
  }

  bool _isChecked = false;
  List<Widget> _buildCheckBoxes() {
    return [
      Text('Checkboxes'),
      Row(children: [
        Directionality(
            textDirection: TextDirection.rtl,
            child: QudsCheckbox(
              value: _isChecked,
              onChanged: (v) => setState(() => _isChecked = v),
            )),
      ]),
      QudsCheckboxListTile(
        title: Text('Hi'),
        value: _isChecked,
        textDirection: TextDirection.rtl,
        onChanged: (v) => setState(() => _isChecked = v),
      ),
      QudsCheckboxWithText(
          textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          text: _isChecked ? 'Selected' : 'Not Selected',
          value: _isChecked,
          onChanged: (v) => setState(() => _isChecked = v)),
      Divider(),
    ];
  }

  List<Widget> _buildAnimatedIcons() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIconsButton(
            // tooltip: 'Toggle',
            iconSize: 50,
            startIcon: Icons.arrow_forward,
            // startIconColor: Colors.white,
            endIcon: Icons.menu,
            endIconColor: Colors.yellow,
            showStartIcon: showStartIcon,
            onPressed: _toggle,
          ),
          QudsAnimatedIconButton(
            iconData: AnimatedIcons.arrow_menu,
            textDirection: TextDirection.rtl,
            showStartIcon: showStartIcon,
            iconSize: 50,
            onPressed: _toggle,
            endIconColor: Colors.yellow,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIconsButton(
            tooltip: 'toggle',
            startIcon: Icons.add,
            endIcon: Icons.event,
            onPressed: _toggle,
            startIconColor: Colors.yellow,
            endIconColor: Colors.red,
            showStartIcon: showStartIcon,
            iconSize: 50,
          ),
          QudsAnimatedIconButton(
            tooltip: 'toggle',
            iconData: AnimatedIcons.add_event,
            onPressed: _toggle,
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
          QudsAnimatedCombinedIconsButton(
            iconSize: 100,
            onPressed: _toggle,
            startIcon: Icons.play_arrow,
            endIcon: Icons.pause,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedIconButton(
            onPressed: _toggle,
            iconSize: 100,
            iconData: AnimatedIcons.play_pause,
            showStartIcon: showStartIcon,
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIconsButton(
            iconSize: 30,
            startIcon: Icons.arrow_back,
            onPressed: _toggle,
            endIcon: Icons.arrow_forward,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIconsButton(
            iconSize: 30,
            onPressed: _toggle,
            startIcon: Icons.arrow_upward,
            endIcon: Icons.arrow_downward,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIconsButton(
            iconSize: 30,
            onPressed: _toggle,
            startIcon: CupertinoIcons.app,
            endIcon: CupertinoIcons.circle,
            showStartIcon: showStartIcon,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QudsAnimatedCombinedIconsButton(
            endIconColor: Colors.green,
            onPressed: _toggle,
            iconSize: 70,
            startIcon: Icons.event,
            endIcon: Icons.event_available,
            showStartIcon: showStartIcon,
          ),
          QudsAnimatedCombinedIconsButton(
            onPressed: _toggle,
            endIconColor: Colors.green,
            iconSize: 70,
            withRotation: false,
            startIcon: Icons.event,
            endIcon: Icons.event_available,
            showStartIcon: showStartIcon,
          ),
        ],
      ),
      QudsAnimatedCombinedIconsButton(
        onPressed: _toggle,
        iconSize: 50,
        startIcon: Icons.accessible,
        endIcon: Icons.accessibility_new,
        showStartIcon: showStartIcon,
      ),
    ];
  }

  void _toggle() {
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
