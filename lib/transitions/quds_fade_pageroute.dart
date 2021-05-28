import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsFadePageRoute<T> extends QudsTransitionPageRoute<T> {
  QudsFadePageRoute(
      {required Widget Function(BuildContext context) builder,
      Duration duration = const Duration(milliseconds: 350),
      Color transitionColor = Colors.black,
      Curve curve = Curves.easeInQuint})
      : super(
            builder: builder,
            duration: duration,
            transitionColor: transitionColor,
            withFade: true,
            curve: curve);
}
