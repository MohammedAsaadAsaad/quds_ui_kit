import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

/// A digital clock viewer with digits flipping effect.
class QudsDigitalTimeViewer extends StatelessWidget {
  /// Weather to show in 24 format.
  final bool format24;

  /// Weather to show day time period `AM` - `PM`.
  final bool showTimePeriod;

  /// The text style of the digits.
  final TextStyle style;

  /// The text style of time period text `AM` - `PM`.
  final TextStyle timePeriodStyle;

  /// AM text, default: `AM`
  final String amText;

  /// PM text, default: `PM`
  final String pmText;

  /// The digits boxes color.
  final Color? backgroundColor;

  /// The hour component value, if set to [null], will not be shown.
  final int? hour;

  /// The minute component value, if set to [null], will not be shown.
  final int? minute;

  /// The second component value, if set to [null], will not be shown.
  final int? second;

  /// The millisecond component value, if set to [null], will not be shown.
  final int? milliSecond;

  /// Create an instance of [QudsDigitalTimeViewer]
  const QudsDigitalTimeViewer(
      {Key? key,
      this.hour,
      this.minute,
      this.second,
      this.milliSecond,
      this.format24 = true,
      this.showTimePeriod = true,
      this.amText = 'AM',
      this.pmText = 'PM',
      this.timePeriodStyle = const TextStyle(fontSize: 24),
      this.style =
          const TextStyle(fontSize: 24, letterSpacing: 3, color: Colors.white),
      this.backgroundColor})
      : assert(hour == null || (hour >= 0 && hour < 24)),
        assert(minute == null || (minute >= 0 && minute < 60)),
        assert(second == null || (second >= 0 && second < 60)),
        assert(milliSecond == null || (milliSecond >= 0 && milliSecond < 1000)),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isMorning = hour != null && hour! < 12;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntrinsicHeight(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hour != null && showTimePeriod) ...[
            QudsAnimatedText(
              isMorning ? amText : pmText,
              style: timePeriodStyle,
            ),
            const SizedBox(
              width: 5,
            )
          ],
          if (hour != null)
            _buildNumberBlock(
                context, format24 ? hour! : (hour! <= 12 ? hour! : hour! - 12)),
          if (hour != null && minute != null) _buildDotsSeperator(),
          if (minute != null) _buildNumberBlock(context, minute!),
          if (minute != null && second != null) _buildDotsSeperator(),
          if (second != null) _buildNumberBlock(context, second!),
          if (second != null && milliSecond != null) _buildDotsSeperator('.'),
          if (milliSecond != null) _buildNumberBlock(context, milliSecond!, 3),
        ],
      )),
    );
  }

  Widget _buildDotsSeperator([String seperator = ':']) => Container(
      alignment: Alignment.center,
      child: Text(
        ' $seperator ',
        style: TextStyle(
            fontSize: style.fontSize,
            letterSpacing: -2,
            fontWeight: FontWeight.bold),
      ));

  Widget _buildNumberBlock(BuildContext context, int number, [int? length]) {
    var backColor = backgroundColor ?? Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: backColor),
      child: QudsAnimatedCounter(number, length: length ?? 2, style: style),
    );
  }
}
