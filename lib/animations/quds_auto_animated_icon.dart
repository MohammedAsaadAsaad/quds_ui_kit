import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../quds_ui_kit.dart';

class QudsAutoAnimatedIcon extends StatefulWidget {
  final AnimatedIconData iconData;
  final Color? color;
  final Color? startIconColor;
  final Color? endIconColor;
  final double? iconSize;
  final bool showStartIcon;
  final Duration duration;
  final bool? withRotation;
  // final Curve curve;
  final TextDirection? textDirection;
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
  /// [duration] the duration of the transition, initially set to `250 ms`
  /// [textDirection] the direction of the icons.
  /// [startAnimationAfter] the duration before the initially shown icon to
  /// start transit.
  const QudsAutoAnimatedIcon(
      {required this.iconData,
      this.color,
      this.startIconColor,
      this.endIconColor,
      this.showStartIcon = false,
      this.withRotation,
      this.iconSize,
      // this.curve = Curves.easeIn,
      this.duration = const Duration(milliseconds: 250),
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
