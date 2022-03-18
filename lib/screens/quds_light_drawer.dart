import 'dart:math';
import 'package:flutter/material.dart';

import '../quds_ui_kit.dart';

/// A drawer with simple design.
class QudsLightDrawer extends StatelessWidget {
  /// The title button of this drawer.
  final Widget? titleButton;

  /// The bottom button of this drawer.
  final Widget? bottomButton;

  /// The bottom about button of this drawer.
  final Widget? bottomAboutButton;

  /// The body of this drawer.
  final Widget? body;

  /// Create an instance of [QudsLightDrawer]
  const QudsLightDrawer({
    Key? key,
    this.body,
    this.titleButton,
    this.bottomButton,
    this.bottomAboutButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextDirection direction = Directionality.of(context);
    bool isLTR = (direction == TextDirection.ltr);
    var size = MediaQuery.of(context).size;

    double cornerRadius = 30;

    var borderRadius = BorderRadius.only(
        topLeft: isLTR ? Radius.zero : Radius.circular(cornerRadius),
        topRight: !isLTR ? Radius.zero : Radius.circular(cornerRadius));

    return SafeArea(
        child: ClipRRect(
            borderRadius: borderRadius,
            child: Material(
              borderOnForeground: true,
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
            )));
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
      QudsBackIconButton(),
      Expanded(child: Container()),
      if (titleButton != null) titleButton!
    ]);
    result = Container(child: result, padding: EdgeInsets.all(5));
    return _revampIconAndText(context, result);
  }

  Widget _buildBottom(BuildContext context) {
    Widget result = Row(children: [
      Expanded(child: this.bottomAboutButton ?? Container()),
      this.bottomButton ?? Container()
    ]);
    result = Container(child: result, padding: EdgeInsets.all(5));
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
