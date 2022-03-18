import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animations.dart';

/// A page route with blur transition.
class QudsBlurPageRoute<T> extends PageRoute<T> {
  /// The builder of the next page.
  final Widget Function(BuildContext context) builder;

  /// The duration of transition.
  final Duration duration;

  /// The barrier color of the transition.
  final Color transitionColor;

  /// The curve of transition.
  final Curve curve;

  /// The initial blur radius.
  final double initialBlurRadius;

  /// Create an instance of [QudsBlurPageRoute].
  QudsBlurPageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    this.transitionColor = Colors.transparent,
    this.curve = Curves.fastOutSlowIn,
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
