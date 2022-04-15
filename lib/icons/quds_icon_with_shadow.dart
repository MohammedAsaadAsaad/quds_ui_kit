import 'package:flutter/material.dart';

/// Icon with shadow.
class QudsIconWithShadow extends StatelessWidget {
  /// The icon data of this widget.
  final IconData iconData;

  /// The color of the icon.
  final Color? color;

  /// The color of the icon shadow.
  final Color? shadowColor;

  /// The offset of the shadow.
  final Offset? offset;

  /// The size of the icon.
  final double? size;

  /// The text direction of the icon.
  final TextDirection? textDirection;

  /// Create an instance of [QudsIconWithShadow].
  const QudsIconWithShadow(
      {Key? key,
      required this.iconData,
      this.size,
      this.color,
      this.shadowColor,
      this.textDirection,
      this.offset})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var icoColor = color ?? IconTheme.of(context).color;
    var icon = Icon(
      iconData,
      color: icoColor,
      size: size,
      textDirection: textDirection,
    );

    var shadowIcon = Icon(
      iconData,
      color: shadowColor ?? icoColor?.withOpacity(0.4),
      size: size,
      textDirection: textDirection,
    );

    var offset = this.offset ?? const Offset(2, 2);

    return Stack(
      children: [
        Positioned.directional(
          textDirection: textDirection ?? Directionality.of(context),
          child: shadowIcon,
          top: offset.dy,
          start: offset.dx,
        ),
        icon,
      ],
    );
  }
}
