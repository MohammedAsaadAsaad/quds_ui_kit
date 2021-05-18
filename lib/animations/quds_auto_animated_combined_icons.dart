import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quds_ui_kit/animations/quds_animated_combined_icons.dart';

/// An auto animated widget that combines two [IconData]s with
/// transition from the first to the second and reverse this transition.
/// It applies rotation with fade effect within icons transition.
class QudsAutoAnimatedCombinedIcons extends StatefulWidget {
  final IconData startIcon;
  final IconData endIcon;
  final Color? color;
  final Color? startIconColor;
  final Color? endIconColor;
  final double? iconSize;
  final bool showStartIcon;
  final Duration duration;
  final bool? withRotation;
  final Curve curve;
  final TextDirection? textDirection;
  final Duration startAnimationAfter;

  /// This widgets consists of [startIcon] & [endIcon],
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the [endIcon],
  /// and automatically transit to [startIcon].
  /// if set to `false` will show initially the [startIcon],
  /// and automatically transit to [endIcon].
  /// [withRotation] indicates weather the icons will transite with rotation.
  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `350 ms`
  /// [textDirection] the direction of the icons.
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedCombinedIcons(
      {required this.startIcon,
      required this.endIcon,
      this.color,
      this.startIconColor,
      this.endIconColor,
      this.showStartIcon = false,
      this.withRotation,
      this.iconSize,
      this.curve = Curves.easeIn,
      this.duration = const Duration(milliseconds: 350),
      this.textDirection,
      this.startAnimationAfter = const Duration(milliseconds: 300)});

  @override
  _QudsAutoAnimatedCombinedIconsState createState() =>
      _QudsAutoAnimatedCombinedIconsState();
}

class _QudsAutoAnimatedCombinedIconsState
    extends State<QudsAutoAnimatedCombinedIcons> {
  late bool _showStartIcon;
  late Timer _tmrSwitchIcon;
  @override
  void initState() {
    _showStartIcon = !widget.showStartIcon;
    _tmrSwitchIcon = Timer(widget.startAnimationAfter, _switchIcons);

    super.initState();
  }

  void _switchIcons() {
    if (mounted) setState(() => _showStartIcon = !_showStartIcon);
  }

  @override
  void dispose() {
    _tmrSwitchIcon.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QudsAnimatedCombinedIcons(
      startIcon: widget.startIcon,
      endIcon: widget.endIcon,
      color: widget.color,
      startIconColor: widget.startIconColor,
      endIconColor: widget.endIconColor,
      showStartIcon: _showStartIcon,
      withRotation: widget.withRotation,
      iconSize: widget.iconSize,
      curve: widget.curve,
      duration: widget.duration,
      textDirection: widget.textDirection,
    );
  }
}
