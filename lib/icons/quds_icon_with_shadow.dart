import 'package:flutter/material.dart';

class QudsIconWithShadow extends StatelessWidget {
  final IconData iconData;
  final Color? color;
  final Color? shadowColor;
  final Offset? offset;
  final double? size;
  final TextDirection? textDirection;

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
    var icoColor = this.color ?? IconTheme.of(context).color;
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

    var offset = this.offset ?? Offset(2, 2);

    return Stack(
      children: [
        Positioned.directional(
          textDirection: this.textDirection ?? Directionality.of(context),
          child: shadowIcon,
          top: offset.dy,
          start: offset.dx,
        ),
        icon,
      ],
    );
  }
}
