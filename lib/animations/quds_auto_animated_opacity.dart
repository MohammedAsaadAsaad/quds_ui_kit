import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// An auto animated widget with fade effect.
class QudsAutoAnimatedOpacity extends StatefulWidget {
  /// The child of this widget
  final Widget child;

  /// The duration of the transition
  final Duration duration;

  /// The curve of the transition
  final Curve curve;

  /// The duration before the transition begin.
  final Duration startAnimationAfter;

  /// The initial opacity of the child. (Before transition start)
  final double initialOpacity;

  /// The final opacity of the child. (After transition end)
  final double finalOpacity;

  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `400 ms`
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedOpacity(
      {required this.child,
      this.initialOpacity = 0,
      this.finalOpacity = 1,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.duration = const Duration(milliseconds: 400),
      this.startAnimationAfter = const Duration(milliseconds: 10)})
      : assert(initialOpacity >= 0 && initialOpacity <= 1),
        assert(finalOpacity >= 0 && finalOpacity <= 1);

  @override
  _QudsAutoAnimatedOpacityState createState() =>
      _QudsAutoAnimatedOpacityState();
}

class _QudsAutoAnimatedOpacityState extends State<QudsAutoAnimatedOpacity> {
  late double _opacity;
  late Timer _tmr;
  @override
  void initState() {
    _opacity = widget.initialOpacity;
    _tmr = Timer(widget.startAnimationAfter, _setOpacity);

    super.initState();
  }

  void _setOpacity() {
    if (mounted) setState(() => _opacity = widget.finalOpacity);
  }

  @override
  void dispose() {
    _tmr.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.duration,
      child: widget.child,
      curve: widget.curve,
    );
  }
}
