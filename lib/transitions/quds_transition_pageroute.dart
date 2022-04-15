import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

/// Page route with combined transition with ability to customize.
class QudsTransitionPageRoute<T> extends PageRoute<T> {
  /// The builder of the next page.
  final Widget Function(BuildContext context) builder;

  /// The duration of transition.
  final Duration duration;

  /// The barrier color of the transition.
  final Color transitionColor;

  /// The curve of transition.
  final Curve curve;

  /// Weather to apply fade transition.
  final bool withFade;

  /// Weather to apply rotation transition.
  final bool withRotate;

  /// Weather to apply zoom transition.
  final bool withZoom;

  /// The zoom type if [withZoom] is set to [true].
  final ZoomType zoomType;

  /// Weather to apply slide transition.
  final bool withSlide;

  /// The slide direction if [withSlide] set to [true].
  final SlideDirection slideDirection;

  /// The rotate alignment if [withRotate] set to [true.]
  final Alignment rotateAlignment;

  /// The scale alignment if [withZoom] set to [true.]
  final Alignment scaleAlignment;

  /// Create an instance of [QudsTransitionPageRoute]
  QudsTransitionPageRoute(
      {required this.builder,
      this.duration = const Duration(milliseconds: 400),
      this.transitionColor = Colors.black,
      this.withFade = true,
      this.withRotate = false,
      this.withZoom = false,
      this.zoomType = ZoomType.In,
      this.withSlide = false,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.slideDirection = SlideDirection.Start,
      this.rotateAlignment = Alignment.center,
      this.scaleAlignment = Alignment.center});
  @override
  Color? get barrierColor => transitionColor;

  @override
  String? get barrierLabel => '';

  @override
  Curve get barrierCurve => curve;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var ch = child;
    if (withRotate) {
      ch = RotationTransition(
        turns: Tween<double>(begin: 0.85, end: 1).animate(animation),
        child: ch,
        alignment: rotateAlignment,
      );

      ch = RotationTransition(
        turns: Tween<double>(begin: 1, end: 1.15).animate(secondaryAnimation),
        child: ch,
        alignment: rotateAlignment,
      );
    }

    if (withZoom) {
      ch = ScaleTransition(
        alignment: scaleAlignment,
        scale: Tween<double>(begin: zoomType == ZoomType.In ? 0.8 : 1.2, end: 1)
            .animate(animation),
        child: ch,
      );

      ch = ScaleTransition(
          alignment: scaleAlignment,
          scale:
              Tween<double>(begin: 1, end: zoomType == ZoomType.In ? 1.7 : 0.3)
                  .animate(secondaryAnimation),
          child: ch);
    }

    if (withFade) {
      ch = FadeTransition(
        opacity: CurvedAnimation(curve: curve, parent: animation),
        child: ch,
      );
    }
    if (withSlide) {
      var isLTR = Directionality.of(context) == TextDirection.ltr;

      var offset = Offset.zero;

      switch (slideDirection) {
        case SlideDirection.Left:
          offset = const Offset(0.5, 0);
          break;

        case SlideDirection.Right:
          offset = const Offset(-0.5, 0);
          break;

        case SlideDirection.Start:
          offset = Offset((isLTR ? 1 : -1) * 0.5, 0);
          break;

        case SlideDirection.End:
          offset = Offset((isLTR ? -1 : 1) * 0.5, 0);
          break;

        case SlideDirection.Up:
          offset = const Offset(0, 0.5);
          break;

        case SlideDirection.Down:
          offset = const Offset(0, -0.5);
          break;
      }

      ch = SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(-offset.dx / 2, -offset.dy / 2),
          ).animate(CurvedAnimation(parent: secondaryAnimation, curve: curve)),
          child: ch);
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
  Duration get transitionDuration => duration;
}
