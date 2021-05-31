import 'package:flutter/material.dart';

/// An animated widget with scale transition after being bressed or mouse hovered.
class QudsScalablePressable extends StatefulWidget {
  /// The child to be scaled.
  final Widget child;

  /// The scale of the child when be pressed or mouse hovered.
  final double scale;

  /// Weather to be scaled when pressed.
  final bool scaleWhenTapDown;

  /// Weather to be scaled when mouse enter child region.
  final bool scaleWhenMouseEnter;

  /// The duration of the transition.
  final Duration duration;

  /// The curve of the transition.
  final Curve curve;

  /// Create an instance of [QudsScalablePressable]
  const QudsScalablePressable(
      {Key? key,
      required this.child,
      this.scale = 1.3,
      this.scaleWhenTapDown = true,
      this.scaleWhenMouseEnter = true,
      this.duration = const Duration(milliseconds: 400),
      this.curve = Curves.fastLinearToSlowEaseIn})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QudsScalablePressable>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(_refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.duration = widget.duration;
    return GestureDetector(
        onTapDown: (d) =>
            !widget.scaleWhenTapDown ? null : _animationController.forward(),
        onTapUp: (d) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        child: MouseRegion(
            onEnter: !widget.scaleWhenMouseEnter
                ? null
                : (d) => _animationController.forward(),
            onExit: (d) => _animationController.reverse(),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (c, w) => Transform.scale(
                  child: widget.child,
                  scale: 1 + (widget.scale - 1) * _animationController.value),
            )));
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
}
