import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animations.dart';

class QudsBlurPageRoute<T> extends PageRoute<T> {
  final Widget Function(BuildContext context) builder;
  final Duration duration;
  final Color transitionColor;
  final Curve curve;
  final double initialBlurRadius;

  QudsBlurPageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 350),
    this.transitionColor = Colors.transparent,
    this.curve = Curves.easeInQuint,
    this.initialBlurRadius = 100,
  });
  @override
  Color? get barrierColor => transitionColor;

  @override
  String? get barrierLabel => '';

  @override
  Curve get barrierCurve => this.curve;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var ch = child;

    return ch;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget ch = builder(context);
    return FadeTransition(
        opacity: CurveTween(curve: this.curve).animate(animation),
        child: QudsAutoAnimatedBlur(
            startAnimationAfter: this.duration,
            child: ch,
            curve: this.curve,
            intialBlurRadius: this.initialBlurRadius,
            duration: this.duration));
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => this.duration;
}
