import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animated_text.dart';
import '../quds_ui_kit.dart';

/// A checkbox with animated text
class QudsCheckboxWithText extends StatelessWidget {
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

  /// The text data of this button.
  final String text;

  /// The text style of this button text.
  final TextStyle? textStyle;

  /// The size of the checkbox.
  final double? checkSize;

  /// [value] the check state of this checkbox
  /// [text] the text will be shown beside the checkbox
  /// [checkColor] the color of the widget when its value set to `true`
  /// [unCheckColor] the color of the widget when its value set to `false`
  /// [onChanged] called when the check state is changed.
  /// [tooltip] a short message shown when the user hold a tap over the checkbox
  /// [iconSize] the size of the ckeck icon.
  const QudsCheckboxWithText(
      {Key? key,
      required this.value,
      required this.text,
      this.checkColor,
      this.unCkeckColor,
      this.onChanged,
      this.tooltip,
      this.checkSize,
      this.textStyle,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkbox = QudsAnimatedCombinedIcons(
      textDirection: this.textDirection,
      iconSize: checkSize,
      startIcon: CupertinoIcons.checkmark_alt_circle_fill,
      endIcon: CupertinoIcons.circle,
      startIconColor: checkColor ?? Theme.of(context).accentColor,
      endIconColor: unCkeckColor ?? Theme.of(context).accentColor,
      showStartIcon: value,
    );

    var text = QudsAnimatedText(
      this.text,
      style: textStyle,
    );
    Widget result = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        checkbox,
        SizedBox(
          width: 5,
        ),
        text
      ],
    );

    result = Container(
      child: result,
      padding: EdgeInsets.all(10),
    );

    if (this.tooltip != null)
      result = Tooltip(
        message: tooltip!,
        child: result,
      );

    result = InkWell(
      child: result,
      onTap: () => onChanged?.call(!value),
    );

    return result;
  }
}
