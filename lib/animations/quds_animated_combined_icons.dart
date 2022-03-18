import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// An animated widget that combines two [IconData]s with
/// transition from the first to the second and reverse this transition.
/// It applies rotation with fade effect within icons transition.
class QudsAnimatedCombinedIcons extends StatelessWidget {
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

  /// This widgets consists of [startIcon] & [endIcon],
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the startIcon,
  /// if set to `false` it will show initially the endIcon.
  /// [withRotation] indicates weather the icons will transite with rotation.
  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `400 ms`
  /// [textDirection] the direction of the icons.
  const QudsAnimatedCombinedIcons({
    required this.startIcon,
    required this.endIcon,
    this.color,
    this.startIconColor,
    this.endIconColor,
    this.iconSize,
    this.showStartIcon = true,
    this.withRotation,
    this.curve = Curves.easeInCubic,
    this.duration = const Duration(milliseconds: 400),
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    var sColor = startIconColor ?? color ?? IconTheme.of(context).color!;
    var eColor = endIconColor ?? color ?? IconTheme.of(context).color!;

    var colorDiffA = eColor.alpha - sColor.alpha;
    var colorDiffB = eColor.blue - sColor.blue;
    var colorDiffR = eColor.red - sColor.red;
    var colorDiffG = eColor.green - sColor.green;

    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: Curves.ease,
      tween: Tween<double>(
          begin: showStartIcon ? 1 : 0, end: !showStartIcon ? 0 : 1),
      builder: (c, v, _) {
        Widget ico1 = Icon(
          startIcon,
          textDirection: textDirection,
          size: iconSize,
          color: Color.fromARGB(
              sColor.alpha + ((1 - v) * colorDiffA).toInt(),
              sColor.red + ((1 - v) * colorDiffR).toInt(),
              sColor.green + ((1 - v) * colorDiffG).toInt(),
              sColor.blue + ((1 - v) * colorDiffB).toInt()),
        );
        Widget ico2 = Icon(
          endIcon,
          size: iconSize,
          textDirection: textDirection,
          color: Color.fromARGB(
              eColor.alpha - (v * colorDiffA).toInt(),
              eColor.red - (v * colorDiffR).toInt(),
              eColor.green - (v * colorDiffG).toInt(),
              eColor.blue - (v * colorDiffB).toInt()),
        );
        ico1 = Opacity(
          child: ico1,
          opacity: v,
        );
        ico2 = Opacity(
          child: ico2,
          opacity: 1 - v,
        );

        if (withRotation != false)
          ico1 = Transform.rotate(
            angle: (1 - v) * pi / 2,
            child: ico1,
          );

        if (withRotation != false)
          ico2 = Transform.rotate(
            angle: v * -pi / 2,
            child: ico2,
          );

        ico1 = Align(
          child: ico1,
          alignment: Alignment.center,
        );

        ico2 = Align(
          child: ico2,
          alignment: Alignment.center,
        );
        return Stack(children: [ico1, ico2]);
      },
    );
  }
}
