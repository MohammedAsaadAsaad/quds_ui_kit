import 'package:example/screens/buttons_screen.dart';
import 'package:example/screens/dialogs_screen.dart';
import 'package:example/screens/viewers_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'bottom_dialogs_screen.dart';
import 'collection_pagination_example.dart';
import 'animations_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QudsLightDrawer(
      bottomAboutButton: Row(
        children: [
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
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          ListTile(
            leading: Icon(CupertinoIcons.circle),
            title: Text('Animations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => AnimationsScreen()));
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
            leading: Icon(CupertinoIcons.list_bullet_below_rectangle),
            title: Text('Collection Pagination'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => CollectionPaginationExample()));
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.viewfinder),
            title: Text('Viewers'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => ViewersScreen()));
            },
          )
        ],
      ),
    );
  }
}
