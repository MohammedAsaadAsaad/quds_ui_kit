import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animations.dart';

class _QudsBorderModalSheet extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final BorderSheetPosition borderSheetPosition;
  final String? titleText;
  final Widget? title;
  final double cornerRadius;
  final Duration duration;
  final Curve curve;

  const _QudsBorderModalSheet(
      {Key? key,
      required this.builder,
      this.borderSheetPosition = BorderSheetPosition.RespectToScreenOrientation,
      this.title,
      this.titleText,
      this.cornerRadius = 15,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);

  @override
  _QudsBorderModalSheetState createState() => _QudsBorderModalSheetState();
}

class _QudsBorderModalSheetState extends State<_QudsBorderModalSheet> {
  double currPosition = 0;

  @override
  Widget build(BuildContext context) {
    Widget ch = widget.builder(context);

    var mediaQuery = MediaQuery.of(context);
    var portrait = mediaQuery.orientation == Orientation.portrait;
    var screenSize = mediaQuery.size;
    late Size sheetMaxSize;
    late Offset offset;
    bool ltr = Directionality.of(context) == TextDirection.ltr;
    late Alignment alignment;
    double? sheetWidth;
    double? sheetHeight;
    BorderRadius? borderRadius;
    double radius = widget.cornerRadius;
    EdgeInsets? padding;
    late _HeaderLinePosition headerLine;

    var _fromVertical = (bool fromBottom) {
      sheetWidth = double.infinity;
      offset = fromBottom ? const Offset(0, 1) : const Offset(0, -1);
      alignment = fromBottom ? Alignment.bottomCenter : Alignment.topCenter;
      sheetMaxSize = Size(double.infinity, screenSize.height * 0.6);
      borderRadius = fromBottom
          ? BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            )
          : BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            );
      padding = const EdgeInsets.symmetric(horizontal: 2);
      headerLine =
          fromBottom ? _HeaderLinePosition.Top : _HeaderLinePosition.Bottom;
    };

    var _fromHorizontal = (bool fromRight) {
      padding = const EdgeInsets.symmetric(vertical: 2);

      sheetHeight = double.infinity;
      offset = Offset(!fromRight ? -1 : 1, 0);
      alignment = !fromRight ? Alignment.centerLeft : Alignment.centerRight;
      sheetMaxSize = Size(min(screenSize.width * .8, 304), double.infinity);
      borderRadius = fromRight
          ? BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
            )
          : BorderRadius.only(
              bottomRight: Radius.circular(radius),
              topRight: Radius.circular(radius),
            );

      headerLine =
          fromRight ? _HeaderLinePosition.Left : _HeaderLinePosition.Right;
    };

    switch (widget.borderSheetPosition) {
      case BorderSheetPosition.RespectToScreenOrientation:
        if (portrait)
          _fromVertical(true);
        else
          _fromHorizontal(ltr);
        break;

      case BorderSheetPosition.RespectToScreenOrientationReversed:
        if (portrait)
          _fromVertical(false);
        else
          _fromHorizontal(!ltr);
        break;
      case BorderSheetPosition.Bottom:
        _fromVertical(true);
        break;
      case BorderSheetPosition.Top:
        _fromVertical(false);
        break;
      case BorderSheetPosition.End:
        _fromHorizontal(ltr == true);
        break;
      case BorderSheetPosition.Start:
        _fromHorizontal(ltr != true);
        break;

      case BorderSheetPosition.Left:
        _fromHorizontal(false);
        break;
      case BorderSheetPosition.Right:
        _fromHorizontal(true);
        break;
    }

    var titleDivider = (widget.title != null || widget.titleText != null)
        ? Divider(
            height: 1,
          )
        : Container();
    var titleComponents = [
      if (widget.borderSheetPosition == BorderSheetPosition.Top) titleDivider,
      if (widget.title != null)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: widget.title,
        ),
      if (widget.title == null && widget.titleText != null)
        Container(
          padding: EdgeInsets.all(5),
          child: Text(
            widget.titleText!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      if (widget.borderSheetPosition != BorderSheetPosition.Top) titleDivider
    ];

    Widget result = Column(mainAxisSize: MainAxisSize.min, children: [
      if (headerLine == _HeaderLinePosition.Top) _buildHorizontalDivider(),
      if (widget.borderSheetPosition != BorderSheetPosition.Top)
        ...titleComponents,
      ch, //Body
      if (widget.borderSheetPosition == BorderSheetPosition.Top)
        ...titleComponents,
      if (headerLine == _HeaderLinePosition.Bottom) _buildHorizontalDivider(),
    ]);

    result = Scrollbar(
        child: SingleChildScrollView(
      child: result,
    ));

    result = Material(
      elevation: 3,
      borderRadius: borderRadius,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((!ltr && headerLine == _HeaderLinePosition.Right) ||
              (ltr && headerLine == _HeaderLinePosition.Left))
            _buildVerticalDivider(),
          Expanded(child: result),
          if ((ltr && headerLine == _HeaderLinePosition.Right) ||
              (!ltr && headerLine == _HeaderLinePosition.Left))
            _buildVerticalDivider(),
        ],
      ),
    );

//Add slide effect
    result = QudsAutoAnimatedSlide(
        curve: widget.curve,
        duration: widget.duration,
        xOffset: offset.dx,
        yOffset: offset.dy,
        child: result);

// //Add opacity effect
//     result = QudsAutoAnimatedOpacity(curve: Curves.ease, child: result);

// //Add scroll if overflowed
//     result = SingleChildScrollView(
//       child: result,
//     );

    result = Container(
        height: sheetHeight,
        width: sheetWidth,
        padding: padding,
        constraints: BoxConstraints(
            maxHeight: sheetMaxSize.height, maxWidth: sheetMaxSize.width),
        child: result);

    result = Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
              ),
              Align(alignment: alignment, child: result),
            ],
          ),
        ));

    result = Scaffold(
      backgroundColor: Colors.transparent,
      body: result,
    );

    return result;
  }

  Widget _buildHorizontalDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 35,
      height: 4,
      decoration: BoxDecoration(
          // boxShadow: [BoxShadow(offset: Offset(0.2, 0.2))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[400]),
    );
  }

  Widget _buildVerticalDivider() {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 4,
      height: 35,
      decoration: BoxDecoration(
          // boxShadow: [BoxShadow(offset: Offset(0.2, 0.2))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[400]),
    ));
  }
}

/// Show modal border.
Future<T?> showQudsModalBorderSheet<T>(
    BuildContext context, Widget Function(BuildContext context) builder,
    {BorderSheetPosition borderSheetPosition =
        BorderSheetPosition.RespectToScreenOrientation,
    String? titleText,
    double cornerRadius = 15,
    Widget? title,
    Curve curve = Curves.fastLinearToSlowEaseIn,
    Duration duration = const Duration(milliseconds: 500)}) async {
  return await showDialog<T>(
      context: context,
      builder: (c) => _QudsBorderModalSheet(
            builder: builder,
            borderSheetPosition: borderSheetPosition,
            title: title,
            titleText: titleText,
            cornerRadius: cornerRadius,
            curve: curve,
            duration: duration,
          ));
}

/// The border sheet position.
enum BorderSheetPosition {
  /// If the screen is portrait, the sheet show at the bottom,
  ///
  /// If landscape, the sheet show at the end (left or right) according to the text direction.
  /// `ltr => right` , `rtl => left`
  RespectToScreenOrientation,

  /// If the screen is portrait, the sheet show at the top,
  ///
  /// If landscape, the sheet show at the end (left or right) according to the text direction.
  /// `ltr => left` , `rtl => right`
  RespectToScreenOrientationReversed,

  /// At the top of the screen.
  Top,

  /// At the left of the screen.
  Left,

  /// At the right of the screen.
  Right,

  /// At the bottom of the screen.
  Bottom,

  /// At the end (left or right) according to the text direction.
  /// `ltr => left` , `rtl => right`
  Start,

  /// At the end (left or right) according to the text direction.
  /// `ltr => right` , `rtl => left`
  End
}

enum _HeaderLinePosition { Top, Bottom, Left, Right }
