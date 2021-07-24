import 'package:example/screens/buttons_screen.dart';
import 'package:example/screens/dialogs_screen.dart';
import 'package:example/screens/page_transitions_screen.dart';
import 'package:example/screens/viewers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'bottom_dialogs_screen.dart';
import 'collections_screen.dart';
import 'animations_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QudsLightDrawer(
      titleButton: IconButton(
        icon: Icon(Icons.done),
        onPressed: () {},
      ),
      bottomAboutButton: Row(
        children: [
          Container(
              child: Image.asset(
            'assets/gif/test_anim.gif',
            height: 45,
            gaplessPlayback: true,
            repeat: ImageRepeat.noRepeat,
          )),
          Icon(Icons.info_outline),
          SizedBox(
            width: 10,
          ),
          Text('About')
        ],
      ),
      bottomButton: IconButton(
        icon: Icon(Icons.share),
        onPressed: () {},
      ),
      body: QudsAnimatedListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          ListTile(
            leading: Icon(CupertinoIcons.circle),
            title: Text('Animations'),
            onTap: () async {
              if (await Navigator.maybePop(context))
                Navigator.push(
                    context,
                    QudsZoomPageRoute(
                        builder: (c) => AnimationsScreen(),
                        transitionColor: Colors.black87));
            },
          ),
          ListTile(
            leading: Icon(Icons.pages_outlined),
            title: Text('Page Transitions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  QudsRotatePageRoute(
                    builder: (c) => PageTransitionsScreen(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.app_fill),
            title: Text('Buttons'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ButtonsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.border_bottom),
            title: Text('Bottom Dialogs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => BottomDialogsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Dialogs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => DialogsScreen()));
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.square_list),
            title: Text('Collections'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => CollectionsScreen()));
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.viewfinder),
            title: Text('Viewers'),
            onTap: () {
              Navigator.maybePop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ViewersScreen()));
            },
          )
        ],
      ),
    );
  }
}
