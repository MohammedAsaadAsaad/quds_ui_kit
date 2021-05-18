import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quds_animated_combined_icons_button.dart';

//A simple circled checkbox
class QudsCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool newValue)? onChanged;
  final Color? checkColor;
  final Color? unCkeckColor;
  final double? size;
  final String? tooltip;

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
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QudsAnimatedCombinedIconsButton(
      padding: EdgeInsets.all(2),
      startIcon: CupertinoIcons.checkmark_alt_circle_fill,
      endIcon: CupertinoIcons.circle,
      startIconColor: checkColor ?? Theme.of(context).accentColor,
      endIconColor: unCkeckColor ?? Theme.of(context).accentColor,
      showStartIcon: value,
      iconSize: size,
      tooltip: this.tooltip,
      onPressed: onChanged == null ? null : () => onChanged!.call(!value),
    );
  }
}
