import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsZoomPageRoute<T> extends QudsTransitionPageRoute<T> {
  QudsZoomPageRoute(
      {required Widget Function(BuildContext context) builder,
      Duration duration = const Duration(milliseconds: 200),
      Color transitionColor = Colors.black,
      bool withFade = true,
      Curve curve = Curves.easeIn,
      Alignment alignment = Alignment.center})
      : super(
            builder: builder,
            duration: duration,
            transitionColor: transitionColor,
            withScale: true,
            withFade: withFade,
            scaleAlignment: alignment,
            curve: curve);
}
