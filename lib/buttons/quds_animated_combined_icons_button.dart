import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animated_combined_icons.dart';
import 'package:quds_ui_kit/buttons/quds_buttons.dart';

/// An animated combined icons button.
class QudsAnimatedCombinedIconsButton extends StatelessWidget {
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

  /// Called when user press this button.
  final VoidCallback? onPressed;

  /// The padding of this widget.
  final EdgeInsets padding;

  /// The tooltip message of this button.
  final String? tooltip;

  /// The focus node of this button.
  final FocusNode? focusNode;

  /// Weather this button occupies the focus automatically.
  final bool autofocus;

  /// Weather the transition between will be performed with rotation
  final bool? withRotation;

  /// The curve of the transition
  final Curve curve;

  /// The direction of the two icons, by default they forward the parent text direction.
  final TextDirection? textDirection;

  /// Defaults to [SystemMouseCursors.click].
  final MouseCursor mouseCursor;

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
  /// [onPressed] called when the user press the button.
  /// [tooltip] a short message shown when the user hold a tap over the button.
  /// [autoFocus] indicates weather the button will be auto focused.
  const QudsAnimatedCombinedIconsButton(
      {required this.startIcon,
      required this.endIcon,
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
      this.textDirection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = QudsAnimatedCombinedIcons(
        curve: curve,
        startIcon: startIcon,
        endIcon: endIcon,
        color: color,
        startIconColor: startIconColor,
        endIconColor: endIconColor,
        iconSize: iconSize,
        withRotation: withRotation,
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

    if (tooltip != null) {
      result = Tooltip(
        message: tooltip!,
        child: result,
      );
    }

    return QudsRadianButton(
      focusNode: focusNode,
      autofocus: autofocus,
      onPressed: onPressed,
      mouseCursor: mouseCursor,
      child: result,
      radius: max(
        Material.defaultSplashRadius,
        (iconSize ?? 2 + min(padding.horizontal, padding.vertical)) * 0.7,
      ),
    );
  }
}
