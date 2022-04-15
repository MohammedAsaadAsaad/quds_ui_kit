import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quds_animated_combined_icons_button.dart';

/// A simple circled checkbox
class QudsCheckbox extends StatelessWidget {
  /// The value of the checkbox.
  final bool value;

  /// Called when this checkbox value changes.
  final Function(bool newValue)? onChanged;

  /// The color of the checkbox when checked.
  final Color? checkColor;

  /// The color of the checkbox when unchecked.
  final Color? unCkeckColor;

  /// The tooltip message of this button.
  final String? tooltip;

  /// The text direction of the checkbox
  final TextDirection? textDirection;

  /// The size of the checkbox.
  final double? size;

  /// [value] the check state of this checkbox
  /// [checkColor] the color of the widget when its value set to `true`
  /// [unCheckColor] the color of the widget when its value set to `false`
  /// [onChanged] called when the check state is changed.
  /// [tooltip] a short message shown when the user hold a tap over the checkbox
  /// [size] the size of the ckeck icon
  const QudsCheckbox(
      {Key? key,
      required this.value,
      this.checkColor,
      this.unCkeckColor,
      this.onChanged,
      this.tooltip,
      this.textDirection,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QudsAnimatedCombinedIconsButton(
      textDirection: textDirection,
      padding: const EdgeInsets.all(2),
      startIcon: CupertinoIcons.checkmark_alt_circle_fill,
      endIcon: CupertinoIcons.circle,
      startIconColor: checkColor ?? Theme.of(context).colorScheme.secondary,
      endIconColor: unCkeckColor ?? Theme.of(context).colorScheme.secondary,
      showStartIcon: value,
      iconSize: size,
      tooltip: tooltip,
      onPressed: onChanged == null ? null : () => onChanged!.call(!value),
    );
  }
}
