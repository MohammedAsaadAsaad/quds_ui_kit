import 'package:flutter/material.dart';

/// A button with radian ink splash effect.
class QudsRadianButton extends StatelessWidget {
  /// Called when the user press this button.
  final void Function()? onPressed;

  /// The focus node of this button.
  final FocusNode? focusNode;

  /// Weather this button occupies the focus automatically.
  final bool autofocus;

  /// The mouse cursor of this button.
  final MouseCursor? mouseCursor;

  /// The child of this button.
  final Widget? child;

  /// The radius of the ink splash.
  final double? radius;

  /// The tooltip message of this button.
  final String? tooltip;

  /// Create an instance of [QudsRadianButton].
  const QudsRadianButton(
      {Key? key,
      this.onPressed,
      this.focusNode,
      this.autofocus = false,
      this.mouseCursor,
      this.radius,
      this.tooltip,
      this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget result = Semantics(
      button: true,
      enabled: onPressed != null,
      child: InkResponse(
        focusNode: focusNode,
        autofocus: autofocus,
        canRequestFocus: onPressed != null,
        onTap: onPressed,
        mouseCursor: mouseCursor,
        child: child,
        radius: radius,
      ),
    );

    if (tooltip != null)
      result = Tooltip(
        message: tooltip!,
        child: result,
      );
    return result;
  }
}
