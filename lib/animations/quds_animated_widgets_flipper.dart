import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QudsAnimatedWidgetsFlipper extends StatelessWidget {
  final Widget startChild;
  final Widget endChild;
  final bool showStartChild;
  final Duration duration;
  final bool? withRotation;
  final Curve curve;

  /// [showStartChild] if is `true` the widget will show initially the startChild,
  /// if set to `false` it will show initially the endChild.
  /// [withRotation] indicates weather the icons will transite with rotation.
  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `250 ms`
  const QudsAnimatedWidgetsFlipper({
    required this.startChild,
    required this.endChild,
    this.showStartChild = true,
    this.withRotation,
    this.curve = Curves.easeIn,
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: Curves.ease,
      tween: Tween<double>(
          begin: showStartChild ? 1 : 0, end: !showStartChild ? 0 : 1),
      builder: (c, v, _) {
        Widget ch1 = startChild;
        Widget ch2 = endChild;
        ch1 = Opacity(
          child: ch1,
          opacity: v,
        );
        ch2 = Opacity(
          child: ch2,
          opacity: 1 - v,
        );

        if (withRotation != false)
          ch1 = Transform.rotate(
            angle: (1 - v) * pi / 2,
            child: ch1,
          );

        if (withRotation != false)
          ch2 = Transform.rotate(
            angle: v * -pi / 2,
            child: ch2,
          );

        ch1 = Align(
          child: ch1,
          alignment: Alignment.center,
        );

        ch2 = Align(
          child: ch2,
          alignment: Alignment.center,
        );
        return Stack(children: [if (v > 0) ch1, if (v < 1) ch2]);
      },
    );
  }
}
