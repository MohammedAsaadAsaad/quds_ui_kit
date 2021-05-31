import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../quds_ui_kit.dart';

/// An auto [AnimatedIconData] animator.
class QudsAutoAnimatedIcon extends StatefulWidget {
  /// The icon data of this widget.
  final AnimatedIconData iconData;

  /// The color of the icon.
  final Color? color;

  /// The color of the start icon.
  final Color? startIconColor;

  /// The color of the end icon.
  final Color? endIconColor;

  /// The size of the animated icon.
  final double? iconSize;

  /// Weather to show the start icon of the end,
  /// if set to [true], start icon will be shown, otherwise end icon will be shown.
  final bool showStartIcon;

  /// The duration of the transition between start end end icons.
  final Duration duration;

  /// The direction of the animated icon, by default they forward the parent text direction.
  final TextDirection? textDirection;

  /// The duration before the transition begin.
  final Duration startAnimationAfter;

  /// This widgets show animated icon with auto animation,
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
  const QudsAutoAnimatedIcon(
      {required this.iconData,
      this.color,
      this.startIconColor,
      this.endIconColor,
      this.showStartIcon = false,
      this.iconSize,
      this.duration = const Duration(milliseconds: 400),
      this.textDirection,
      this.startAnimationAfter = const Duration(milliseconds: 300)});

  @override
  _QudsAutoAnimatedCombinedIconsState createState() =>
      _QudsAutoAnimatedCombinedIconsState();
}

class _QudsAutoAnimatedCombinedIconsState extends State<QudsAutoAnimatedIcon> {
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
    return QudsAnimatedIcon(
      iconData: widget.iconData,
      color: widget.color,
      startIconColor: widget.startIconColor,
      endIconColor: widget.endIconColor,
      showStartIcon: _showStartIcon,
      iconSize: widget.iconSize,
      // curve: widget.curve,
      duration: widget.duration,
      textDirection: widget.textDirection,
    );
  }
}
