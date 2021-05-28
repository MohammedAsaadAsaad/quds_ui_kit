import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QudsAutoAnimatedBlur extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration startAnimationAfter;
  final double intialBlurRadius;

  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `250 ms`
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedBlur(
      {required this.child,
      this.intialBlurRadius = 10,
      this.curve = Curves.easeIn,
      this.duration = const Duration(milliseconds: 500),
      this.startAnimationAfter = const Duration(milliseconds: 10)});

  @override
  _QudsAutoAnimatedBlurState createState() => _QudsAutoAnimatedBlurState();
}

class _QudsAutoAnimatedBlurState extends State<QudsAutoAnimatedBlur> {
  late double _radius;

  late Timer _tmr;
  @override
  void initState() {
    _radius = this.widget.intialBlurRadius;
    _tmr = Timer(widget.startAnimationAfter, () {
      if (mounted)
        setState(() {
          _radius = 0;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tmr.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: this.widget.curve,
      tween: Tween<double>(begin: 1, end: 0),
      duration: this.widget.duration,
      builder: (c, v, w) => ClipRect(
          child: Stack(
        alignment: Alignment.center,
        children: [
          this.widget.child,
          BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: v * _radius, sigmaY: v * _radius),
              child: Container())
        ],
      )),
    );
  }
}
