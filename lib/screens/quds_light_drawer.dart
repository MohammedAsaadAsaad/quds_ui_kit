import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QudsLightDrawer extends StatelessWidget {
  final Widget? titleButton;
  final Widget? bottomButton;
  final Widget? bottomAboutButton;
  final Widget? body;

  const QudsLightDrawer(
      {Key? key,
      this.body,
      this.titleButton,
      this.bottomButton,
      this.bottomAboutButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextDirection direction = Directionality.of(context);
    var size = MediaQuery.of(context).size;

    double cornerRadius = 30;

    var borderRadius =
        BorderRadiusDirectional.only(topEnd: Radius.circular(cornerRadius));

    return SafeArea(
        child: Material(
      borderRadius: borderRadius,
      color: theme.primaryColor,
      shadowColor: theme.iconTheme.color!,
      child: Container(
        margin: EdgeInsets.only(top: 0),
        width: min(size.width * .8, 304),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: _buildBody(context, theme, direction),
            ),
            _buildBottom(context)
          ],
        ),
      ),
    ));
  }

  Widget _buildBody(
      BuildContext context, ThemeData theme, TextDirection direction) {
    bool isLtr = direction == TextDirection.ltr;

    double cornerRadius = 20;
    var radius = Radius.circular(cornerRadius);
    var borderRadius = isLtr
        ? BorderRadius.only(topRight: radius, bottomRight: radius)
        : BorderRadius.only(topLeft: radius, bottomLeft: radius);
    return Container(
        margin: EdgeInsetsDirectional.only(end: 5),
        width: double.infinity,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Column(
            children: [
              Expanded(child: Material(child: body)),
            ],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    Widget result =
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      Expanded(child: Container()),
      if (titleButton != null) titleButton!
    ]);
    return _revampIconAndText(context, result);
  }

  Widget _buildBottom(BuildContext context) {
    Widget result = Row(children: [
      this.bottomAboutButton ?? Container(),
      Expanded(child: Container()),
      this.bottomButton ?? Container()
    ]);

    return _revampIconAndText(context, result);
  }

  Widget _revampIconAndText(BuildContext context, Widget w) {
    var theme = Theme.of(context);
    Widget result = IconTheme(data: theme.primaryIconTheme, child: w);
    result = DefaultTextStyle(
        style: theme.primaryTextTheme.bodyText1!.copyWith(fontSize: 18),
        child: result);
    return result;
  }
}
