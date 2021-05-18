import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

/// A listtile with a checkbox
class QudsCheckboxListTile extends StatelessWidget {
  final Widget? title;
  final ListTileControlAffinity controlAffinity;
  final bool value;
  final Function(bool newValue)? onChanged;
  final double? size;
  final Color? checkColor;
  final Color? unCkeckColor;
  final String? tooltip;
  final TextDirection? textDirection;
  final Widget? secondary;
  final bool isThreeLine;

  /// [value] the check state of this checkbox
  /// [checkColor] the color of the widget when its value set to `true`
  /// [unCheckColor] the color of the widget when its value set to `false`
  /// [onChanged] called when the check state is changed.
  /// [tooltip] a short message shown when the user hold a tap over the checkbox
  /// [size] the size of the ckeck icon.
  const QudsCheckboxListTile(
      {Key? key,
      required this.value,
      this.controlAffinity = ListTileControlAffinity.leading,
      this.title,
      this.secondary,
      this.checkColor,
      this.unCkeckColor,
      this.onChanged,
      this.tooltip,
      this.textDirection,
      this.isThreeLine = false,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget checkbox = QudsAnimatedCombinedIcons(
      startIcon: CupertinoIcons.checkmark_alt_circle_fill,
      endIcon: CupertinoIcons.circle,
      startIconColor: checkColor ?? Theme.of(context).accentColor,
      endIconColor: unCkeckColor ?? Theme.of(context).accentColor,
      iconSize: size,
      showStartIcon: value,
      textDirection: textDirection,
    );

    checkbox = Container(
      child: checkbox,
      width: 40,
    );

    Widget? leading, trailing;
    switch (controlAffinity) {
      case ListTileControlAffinity.leading:
        leading = checkbox;
        trailing = secondary;
        break;
      case ListTileControlAffinity.trailing:
      case ListTileControlAffinity.platform:
        leading = secondary;
        trailing = checkbox;
        break;
    }

    return ListTile(
      isThreeLine: isThreeLine,
      title: title,
      leading: leading,
      trailing: trailing,
      onTap: () => onChanged?.call(!value),
    );
  }
}
