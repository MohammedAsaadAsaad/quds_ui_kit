import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

/// A listtile with a checkbox
class QudsCheckboxListTile extends StatelessWidget {
  /// The title widget of this list tile
  final Widget? title;

  /// The position of the checkbox of this list tile.
  final ListTileControlAffinity controlAffinity;

  /// The value of the checkbox of this list tile.
  final bool value;

  /// Called when this checkbox value changes.
  final Function(bool newValue)? onChanged;

  /// The size of the checkbox.
  final double? size;

  /// The color of the checkbox when checked.
  final Color? checkColor;

  /// The color of the checkbox when unchecked.
  final Color? unCkeckColor;

  /// The tooltip message of this listtile
  final String? tooltip;

  /// The text direction of the checkbox
  final TextDirection? textDirection;

  /// The secondary widget of this listtile.
  final Widget? secondary;

  /// Weather if the listtile has three lines.
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
      startIconColor: checkColor ?? Theme.of(context).colorScheme.secondary,
      endIconColor: unCkeckColor ?? Theme.of(context).colorScheme.secondary,
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
