import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

/// A page route with fade transition.
class QudsFadePageRoute<T> extends QudsTransitionPageRoute<T> {
  /// Create an instance of [QudsFadePageRoute].
  QudsFadePageRoute(
      {required Widget Function(BuildContext context) builder,
      Duration duration = const Duration(milliseconds: 700),
      Color transitionColor = Colors.black,
      Curve curve = Curves.easeIn})
      : super(
            builder: builder,
            duration: duration,
            transitionColor: transitionColor,
            withFade: true,
            curve: curve);
}
