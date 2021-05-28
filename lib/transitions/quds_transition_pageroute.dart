import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsTransitionPageRoute<T> extends PageRoute<T> {
  final Widget Function(BuildContext context) builder;
  final Duration duration;
  final Color transitionColor;
  final bool withFade;
  final bool withRotate;
  final bool withZoom;
  final ZoomType zoomType;
  final bool withSlide;
  final SlideDirection slideDirection;
  final Curve curve;
  final Alignment rotateAlignment;
  final Alignment scaleAlignment;

  QudsTransitionPageRoute(
      {required this.builder,
      this.duration = const Duration(milliseconds: 350),
      this.transitionColor = Colors.black,
      this.withFade = true,
      this.withRotate = false,
      this.withZoom = false,
      this.zoomType = ZoomType.In,
      this.withSlide = false,
      this.curve = Curves.easeInQuint,
      this.slideDirection = SlideDirection.Start,
      this.rotateAlignment = Alignment.center,
      this.scaleAlignment = Alignment.center});
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
    if (this.withRotate)
      ch = RotationTransition(
        turns: CurvedAnimation(curve: this.curve, parent: animation),
        child: ch,
        alignment: rotateAlignment,
      );

    if (this.withZoom)
      ch = ScaleTransition(
        alignment: this.scaleAlignment,
        scale: Tween<double>(
                begin: this.zoomType == ZoomType.In ? 0.8 : 1.2, end: 1)
            .animate(animation),

        //  CurvedAnimation(
        //     curve: this.curve,
        //     parent: Tween<double>(
        //             begin: this.zoomType == ZoomType.In ? 0.9 : 1.3, end: 1)
        //         .animate(animation)),
        child: ch,
      );

    if (this.withFade)
      ch = FadeTransition(
        opacity: CurvedAnimation(curve: this.curve, parent: animation),
        child: ch,
      );

    if (this.withSlide) {
      var isLTR = Directionality.of(context) == TextDirection.ltr;

      var offset = Offset.zero;

      switch (this.slideDirection) {
        case SlideDirection.Left:
          offset = Offset(0.5, 0);
          break;

        case SlideDirection.Right:
          offset = Offset(-0.5, 0);
          break;

        case SlideDirection.Start:
          offset = Offset((isLTR ? 1 : -1) * 0.5, 0);
          break;

        case SlideDirection.End:
          offset = Offset((isLTR ? -1 : 1) * 0.5, 0);
          break;

        case SlideDirection.Up:
          offset = Offset(0, 0.5);
          break;

        case SlideDirection.Down:
          offset = Offset(0, -0.5);
          break;
      }

      ch = SlideTransition(
        position: Tween<Offset>(
          begin: offset,
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: curve)),
        child: ch, // child is the value returned by pageBuilder
      );
    }
    return ch;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget ch = builder(context);
    return ch;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => this.duration;
}
