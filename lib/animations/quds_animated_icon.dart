import 'package:flutter/material.dart';

/// A wrap of flutter embedded [AnimatedIcon]s with simlpe control.
class QudsAnimatedIcon extends StatefulWidget {
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

  /// [iconData] the [AnimatedIconData] will be shown in this widget.
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the startIcon,
  /// if set to `false` it will show initially the endIcon.
  /// [duration] the duration of the transition, initially set to `250 ms`
  /// [textDirection] the direction of the icons.
  const QudsAnimatedIcon(
      {required this.iconData,
      this.color,
      this.startIconColor,
      this.endIconColor,
      this.iconSize,
      this.showStartIcon = true,
      this.textDirection,
      this.duration = const Duration(milliseconds: 250)});

  @override
  _QudsAnimatedIconState createState() => _QudsAnimatedIconState();
}

class _QudsAnimatedIconState extends State<QudsAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _showFirst;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: widget.duration, lowerBound: 0, upperBound: 1)
      ..addListener(_refresh)
      ..value = widget.showStartIcon != false ? 0 : 1;
    _showFirst = widget.showStartIcon != false;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(_refresh);
    _animationController.dispose();

    super.dispose();
  }

  void _refresh() => setState(() {});
  @override
  Widget build(BuildContext context) {
    var t = widget.showStartIcon != false;
    if (_showFirst != t) {
      _showFirst = t;
      if (_showFirst)
        _animationController.reverse();
      else
        _animationController.forward();
    }
    var sColor =
        widget.startIconColor ?? widget.color ?? IconTheme.of(context).color!;
    var eColor =
        widget.endIconColor ?? widget.color ?? IconTheme.of(context).color!;

    var colorDiffA = eColor.alpha - sColor.alpha;
    var colorDiffB = eColor.blue - sColor.blue;
    var colorDiffR = eColor.red - sColor.red;
    var colorDiffG = eColor.green - sColor.green;

    var v = _animationController.value;

    Widget ico = AnimatedIcon(
        icon: widget.iconData,
        progress: _animationController,
        size: widget.iconSize,
        textDirection: widget.textDirection,
        color: Color.fromARGB(
            sColor.alpha + (v * colorDiffA).toInt(),
            sColor.red + (v * colorDiffR).toInt(),
            sColor.green + (v * colorDiffG).toInt(),
            sColor.blue + (v * colorDiffB).toInt()));

    return Center(child: ico);
  }
}
