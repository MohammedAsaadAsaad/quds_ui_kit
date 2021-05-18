import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:quds_ui_kit/animations/quds_animated_combined_icons.dart';

/// An animated combined icons button.
class QudsAnimatedCombinedIconsButton extends StatelessWidget {
  final IconData startIcon;
  final IconData endIcon;
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

  /// This widgets consists of [startIcon] & [endIcon],
  /// [color] is the icons color, will be applied to the
  /// both of icons, unless [startIconColor], [endIconColor] are set.
  /// [iconSize] is the size of the two icons.
  /// [showStartIcon] if is `true` the widget will show initially the startIcon,
  /// if set to `false` it will show initially the endIcon.
  /// [withRotation] indicates weather the icons will transite with rotation.
  /// [curve] the curve of the transition velocity.
  /// [duration] the duration of the transition, initially set to `250 ms`
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
      this.curve = Curves.ease,
      this.padding = const EdgeInsets.all(8.0),
      this.duration = const Duration(milliseconds: 250),
      this.mouseCursor = SystemMouseCursors.click,
      this.textDirection});

  @override
  Widget build(BuildContext context) {
    Widget result = QudsAnimatedCombinedIcons(
        curve: this.curve,
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

    if (tooltip != null)
      result = Tooltip(
        message: tooltip!,
        child: result,
      );

    return Semantics(
      button: true,
      enabled: onPressed != null,
      child: InkResponse(
        focusNode: focusNode,
        autofocus: autofocus,
        canRequestFocus: onPressed != null,
        onTap: onPressed,
        mouseCursor: mouseCursor,
        child: result,
        radius: max(
          Material.defaultSplashRadius,
          (iconSize ?? 2 + min(padding.horizontal, padding.vertical)) * 0.7,
          // x 0.5 for diameter -> radius and + 40% overflow derived from other Material apps.
        ),
      ),
    );
  }
}
