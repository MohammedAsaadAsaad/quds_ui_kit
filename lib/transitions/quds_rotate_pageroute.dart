import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsRotatePageRoute<T> extends QudsTransitionPageRoute<T> {
  final Widget Function(BuildContext context) builder;

  QudsRotatePageRoute(
      {required this.builder,
      Duration duration = const Duration(milliseconds: 400),
      Color transitionColor = Colors.black,
      Curve curve = Curves.fastLinearToSlowEaseIn,
      Alignment alignment = Alignment.center,
      bool withFade = true})
      : super(
            builder: builder,
            duration: duration,
            transitionColor: transitionColor,
            withRotate: true,
            withFade: withFade,
            rotateAlignment: alignment,
            curve: curve);
}
