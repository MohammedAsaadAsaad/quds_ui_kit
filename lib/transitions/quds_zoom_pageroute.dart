import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsZoomPageRoute<T> extends QudsTransitionPageRoute<T> {
  QudsZoomPageRoute(
      {required Widget Function(BuildContext context) builder,
      Duration duration = const Duration(milliseconds: 300),
      Color transitionColor = Colors.black26,
      bool withFade = true,
      Curve curve = Curves.easeInOut,
      Alignment alignment = Alignment.center,
      ZoomType zoomType = ZoomType.In})
      : super(
            builder: builder,
            duration: duration,
            transitionColor: transitionColor,
            withZoom: true,
            withFade: withFade,
            scaleAlignment: alignment,
            curve: curve,
            zoomType: zoomType);
}
