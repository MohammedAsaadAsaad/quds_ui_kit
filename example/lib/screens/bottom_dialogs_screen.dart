import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class BottomDialogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<BottomDialogsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(actions: [], title: Text('Bottom Dialogs')),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[..._buildBottomSheet(), ..._buildToast()],
      ),
    );
  }

  List<Widget> _buildBottomSheet() {
    return [
      Text(
        'Bottom Sheet',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      ElevatedButton(
          child: Text('With title'),
          onPressed: () => showQudsModalBottomSheet(
              context,
              (c) => Column(
                    children: [
                      for (int i = 0; i < 5; i++) ListTile(title: Text('Hi'))
                    ],
                  ),
              titleText: 'Test Bottom Sheet')),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          child: Text('Without title'),
          onPressed: () => showQudsModalBottomSheet(
                context,
                (c) => Column(
                  children: [
                    for (int i = 0; i < 3; i++) ListTile(title: Text('Hi'))
                  ],
                ),
              )),
      Divider(),
    ];
  }

  List<Widget> _buildToast() {
    return [
      Text('Toasts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          )),
      ElevatedButton(
          onPressed: () => showQudsToast(context,
              toastTime: QudsToastTime.VeryShort, content: Text('Test toast')),
          child: Text('With content')),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          onPressed: () => showQudsToast(context,
                  content: Text('Copied!'),
                  toastTime: QudsToastTime.VeryShort,
                  leadingActions: [
                    QudsAutoAnimatedCombinedIcons(
                      startIcon: Icons.copy,
                      endIcon: Icons.paste,
                      showStartIcon: false,
                    )
                  ]),
          child: Text('With leading actions')),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          onPressed: () => showQudsToast(context,
                  content: Text('Deleted!'),
                  toastTime: QudsToastTime.Normal,
                  trailingActions: [
                    InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: QudsAutoAnimatedCombinedIcons(
                              startIcon: CupertinoIcons.delete,
                              endIcon: CupertinoIcons.arrow_turn_up_left,
                              showStartIcon: false,
                            )))
                  ]),
          child: Text('With trailing actions')),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          onPressed: () => showQudsToast(
                context,
                backgroundColor: Colors.red,
                content: Text('Colored!'),
                toastTime: QudsToastTime.Normal,
              ),
          child: Text('Colored toast')),
      SizedBox(
        height: 5,
      ),
      Divider(),
    ];
  }
}
