import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../quds_ui_kit.dart';

//A flutter animated icon button
class QudsAnimatedIconButton extends StatelessWidget {
  final AnimatedIconData iconData;
  final Color? color;
  final Color? startIconColor;
  final Color? endIconColor;
  final double? iconSize;
  final bool showStartIcon;
  final Duration duration;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  final String? tooltip;
  final FocusNode? focusNode;

  final bool autofocus;
  final bool? withRotation;
  final Curve curve;
  final TextDirection? textDirection;

  /// Defaults to [SystemMouseCursors.click].
  final MouseCursor mouseCursor;

  /// [iconData] the [AnimatedIconData] will be shown in this widget.
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the startIcon,
  /// if set to `false` it will show initially the endIcon.
  /// [duration] the duration of the transition, initially set to `400 ms`
  /// [textDirection] the direction of the icons.
  /// [textDirection] the direction of the icons.
  /// [onPressed] called when the user press the button.
  /// [tooltip] a short message shown when the user hold a tap over the button.
  /// [autoFocus] indicates weather the button will be auto focused.
  const QudsAnimatedIconButton(
      {required this.iconData,
      this.startIconColor,
      this.endIconColor,
      this.color,
      this.showStartIcon = true,
      this.onPressed,
      this.tooltip,
      this.autofocus = false,
      this.focusNode,
      this.iconSize = 24,
      this.withRotation,
      this.curve = Curves.fastLinearToSlowEaseIn,
      this.padding = const EdgeInsets.all(8.0),
      this.duration = const Duration(milliseconds: 400),
      this.mouseCursor = SystemMouseCursors.click,
      this.textDirection});

  @override
  Widget build(BuildContext context) {
    Widget result = QudsAnimatedIcon(
        iconData: this.iconData,
        color: color,
        startIconColor: startIconColor,
        endIconColor: endIconColor,
        iconSize: iconSize,
        duration: duration,
        showStartIcon: showStartIcon,
        textDirection: textDirection);

    result = SizedBox(
      width: iconSize,
      height: iconSize,
      child: result,
    );

    result = Padding(
      padding: padding,
      child: result,
    );

    if (tooltip != null)
      result = Tooltip(
        message: tooltip!,
        child: result,
      );

    return QudsRadianButton(
      child: result,
      focusNode: focusNode,
      autofocus: autofocus,
      onPressed: onPressed,
      mouseCursor: mouseCursor,
      radius: max(
        Material.defaultSplashRadius,
        (iconSize ?? 2 + min(padding.horizontal, padding.vertical)) * 0.7,
      ),
    );
  }
}
