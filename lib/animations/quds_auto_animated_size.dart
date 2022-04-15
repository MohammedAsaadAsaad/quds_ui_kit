import 'dart:async';
import 'package:flutter/material.dart';

/// An animated size widget that start animation after a while
class QudsAutoAnimatedSize extends StatefulWidget {
  /// The child of this widget.
  final Widget child;

  /// The duration of resizing.
  final Duration duration;

  /// The duration before first animation.
  final Duration startAfterDuration;

  /// The alignment of resizing origin.
  final AlignmentGeometry alignment;

  /// Creates an instance of [QudsAutoAnimatedSize]
  const QudsAutoAnimatedSize(
      {Key? key,
      required this.child,
      this.alignment = Alignment.center,
      this.startAfterDuration = const Duration(milliseconds: 50),
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _QudsAutoAnimatedSizeSize();
}

class _QudsAutoAnimatedSizeSize extends State<QudsAutoAnimatedSize>
    with SingleTickerProviderStateMixin {
  bool showChild = false;

  @override
  void initState() {
    super.initState();
    Timer(widget.startAfterDuration, () {
      showChild = true;
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: widget.alignment,
      child: showChild
          ? widget.child
          : const SizedBox(
              width: 1,
              height: 1,
            ),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: widget.duration,
    );
  }
}
