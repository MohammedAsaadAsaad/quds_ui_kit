import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QudsAutoAnimatedSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration startAnimationAfter;
  final double xOffset;
  final double yOffset;
  final TextDirection? textDirection;

  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `250 ms`
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedSlide(
      {required this.child,
      this.xOffset = 0.7,
      this.yOffset = 0,
      this.textDirection,
      this.curve = Curves.easeIn,
      this.duration = const Duration(milliseconds: 250),
      this.startAnimationAfter = const Duration(milliseconds: 10)});

  @override
  _QudsAutoAnimatedOpacityState createState() =>
      _QudsAutoAnimatedOpacityState();
}

class _QudsAutoAnimatedOpacityState extends State<QudsAutoAnimatedSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.addListener(_refresh);
    _animationController.forward();
    super.initState();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _animationController.removeListener(_refresh);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.duration = widget.duration;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(widget.xOffset, widget.yOffset),
        end: Offset.zero,
      ).animate(
          CurvedAnimation(parent: _animationController, curve: widget.curve)),
      child: widget.child, // child is the value returned by pageBuilder
    );
  }
}
