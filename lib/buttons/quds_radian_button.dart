import 'package:flutter/material.dart';

class QudsRadianButton extends StatelessWidget {
  final void Function()? onPressed;
  final FocusNode? focusNode;
  final bool autofocus;
  final MouseCursor? mouseCursor;
  final Widget? child;
  final double? radius;
  final String? tooltip;
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
