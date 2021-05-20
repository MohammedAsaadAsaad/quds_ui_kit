import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QudsAutoAnimatedOpacity extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration startAnimationAfter;
  final double initialOpacity;
  final double finalOpacity;

  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `350 ms`
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedOpacity(
      {required this.child,
      this.initialOpacity = 0,
      this.finalOpacity = 1,
      this.curve = Curves.easeIn,
      this.duration = const Duration(milliseconds: 350),
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
