import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

/// A page route with rotation transition.
class QudsRotatePageRoute<T> extends QudsTransitionPageRoute<T> {
  final Widget Function(BuildContext context) builder;

  /// Create an instance of [QudsRotatePageRoute].
  QudsRotatePageRoute(
      {required this.builder,
      Duration duration = const Duration(milliseconds: 400),
      Color transitionColor = Colors.black,
      Curve curve = Curves.linear,
      Alignment alignment = Alignment.bottomLeft,
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
