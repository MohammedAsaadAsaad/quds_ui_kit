import 'package:flutter/material.dart';

class QudsScalablePressable extends StatefulWidget {
  final Widget child;
  final double scale;
  final bool scaleWhenTapDown;
  final bool scaleWhenMouseEnter;
  final Duration duration;
  final Curve curve;

  const QudsScalablePressable(
      {Key? key,
      required this.child,
      this.scale = 1.3,
      this.scaleWhenTapDown = true,
      this.scaleWhenMouseEnter = true,
      this.duration = const Duration(milliseconds: 200),
      this.curve = Curves.easeIn})
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
