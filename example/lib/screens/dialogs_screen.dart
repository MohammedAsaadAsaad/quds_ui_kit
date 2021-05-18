import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class DialogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DialogsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: AppBar(actions: [], title: Text('Dialogs')),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(10),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ..._buildDialogs(),
          ..._buildCustomDialogs(),
        ],
      ),
    );
  }

  bool _showTitle = true;
  bool _showContent = true;
  bool _showLeading = true;
  bool _showActions = true;
  Alignment _alignment = Alignment.center;

  List<Widget> _buildDialogs() {
    return [
      Text(
        'Dialogs',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      Wrap(
        children: [
          QudsCheckboxWithText(
              onChanged: (v) => setState(() => _showTitle = v),
              value: _showTitle,
              text: _showTitle ? 'With title' : 'Without title'),
          QudsCheckboxWithText(
              onChanged: (v) => setState(() => _showLeading = v),
              value: _showLeading,
              text: _showLeading ? 'With leading' : 'Without leading'),
          QudsCheckboxWithText(
              onChanged: (v) => setState(() => _showContent = v),
              value: _showContent,
              text: _showContent ? 'With content' : 'Without content'),
          QudsCheckboxWithText(
              onChanged: (v) => setState(() => _showActions = v),
              value: _showActions,
              text: _showActions ? 'With actions' : 'Without actions'),
          DropdownButton<Alignment>(
              icon: Icon(Icons.format_align_center),
              onChanged: (v) => setState(() => _alignment = v!),
              value: _alignment,
              items: [
                Alignment.topCenter,
                Alignment.centerLeft,
                Alignment.center,
                Alignment.centerRight,
                Alignment.bottomCenter
              ]
                  .map<DropdownMenuItem<Alignment>>(
                      (e) => DropdownMenuItem<Alignment>(
                            value: e,
                            child: Text(e.toString()),
                          ))
                  .toList())
        ],
      ),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          child: Text('Show Dialog'), onPressed: () => _showDialog()),
      Divider(),
    ];
  }

  void _showDialog() {
    showQudsDialog(context,
            alignment: _alignment,
            leadingActions: !_showLeading
                ? null
                : [
                    QudsAutoAnimatedCombinedIcons(
                        startIcon: Icons.info_outline,
                        endIcon: Icons.save_outlined)
                  ],
            title: !_showTitle ? null : Text('Save'),
            // alignment: Alignment.topCenter,
            actions: !_showActions
                ? null
                : [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'save');
                        },
                        child: Text('Save')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'cancel');
                        },
                        child: Text('Cancel'))
                  ],
            builder: !_showContent
                ? null
                : (c) => Text(
                    'Would you like to save the document before existing?'))
        .then((value) {
      switch (value) {
        case 'save':
          showQudsToast(context, content: Text('Saved!'), leadingActions: [
            QudsAutoAnimatedCombinedIcons(
                startIcon: Icons.save, endIcon: Icons.done)
          ]);
          break;

        case 'cancel':
          showQudsToast(context, content: Text('Canceled!'));
          break;
      }
    });
  }

  List<Widget> _buildCustomDialogs() {
    return [
      Text(
        'Custom Dialogs',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          child: Text('Delete Dialog'),
          onPressed: () => showQudsConfirmDeleteDialog(context,
              onDeletePressed: () => showQudsToast(context,
                  leadingActions: [
                    QudsAutoAnimatedCombinedIcons(
                        startIcon: Icons.delete, endIcon: Icons.done)
                  ],
                  content: Text('Deleted!'),
                  trailingActions: [
                    InkWell(
                        onTap: () {
                          showQudsToast(context, content: Text('Undo pressed'));
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: QudsAutoAnimatedCombinedIcons(
                              startIcon: CupertinoIcons.delete,
                              endIcon: CupertinoIcons.arrow_turn_up_left,
                              showStartIcon: false,
                            )))
                  ]))),
      SizedBox(
        height: 5,
      ),
      ElevatedButton(
          child: Text('Exit Dialog'),
          onPressed: () => showQudsConfirmExitDialog(context,
              onExitPressed: () => Navigator.pop(context))),
      SizedBox(
        height: 5,
      ),
      Divider(),
    ];
  }
}
