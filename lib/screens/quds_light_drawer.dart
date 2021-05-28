import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../quds_ui_kit.dart';

class QudsLightDrawer extends StatelessWidget {
  final Widget? titleButton;
  final Widget? bottomButton;
  final Widget? bottomAboutButton;
  final Widget? body;
  final String? backButtonTooltip;
  const QudsLightDrawer(
      {Key? key,
      this.body,
      this.titleButton,
      this.bottomButton,
      this.bottomAboutButton,
      this.backButtonTooltip})
      : super(key: key);

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
      QudsBackIcon(tooltip: this.backButtonTooltip ?? 'Back'),
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
