import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quds_ui_kit/animations/quds_animated_combined_icons.dart';

/// An auto animated widget that combines two [IconData]s with
/// transition from the first to the second and reverse this transition.
/// It applies rotation with fade effect within icons transition.
class QudsAutoAnimatedCombinedIcons extends StatefulWidget {
  /// The start Icon of this widget
  final IconData startIcon;

  /// The end Icon of this widget
  final IconData endIcon;

  /// The default color of the two icons [startIcon], [endIcon]
  final Color? color;

  /// The color of the startIcon, if [startIconColor] will be set to the start color, otherwise [color] will be set.
  final Color? startIconColor;

  /// The color of the endIcon, if [endIconColor] will be set to the end color, otherwise [color] will be set.
  final Color? endIconColor;

  /// The size of the two icons [startIcon], [endIcon]
  final double? iconSize;

  /// Weather to show [startIcon] or [endIcon],
  /// if set to [true] [startIcon] will be shown, otherwise [endIcon] will be shown
  final bool showStartIcon;

  /// The duration of transition between the two icons [startIcon] or [endIcon].
  final Duration duration;

  /// Weather the transition between will be performed with rotation
  final bool? withRotation;

  /// The curve of the transition
  final Curve curve;

  /// The direction of the two icons, by default they forward the parent text direction.
  final TextDirection? textDirection;

  /// The duration before the transition begin.
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
  /// [duration] the duration of the transition, initially set to `400 ms`
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
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.duration = const Duration(milliseconds: 400),
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
