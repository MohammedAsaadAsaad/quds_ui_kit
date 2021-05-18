import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

class QudsDigitalTimeViewer extends StatelessWidget {
  final int? hour;
  final int? minute;
  final int? second;
  final int? milliSecond;
  final TextStyle style;
  final bool format24;

  const QudsDigitalTimeViewer(
      {Key? key,
      this.hour,
      this.minute,
      this.second,
      this.milliSecond,
      this.format24 = true,
      this.style =
          const TextStyle(fontSize: 24, letterSpacing: 3, color: Colors.white)})
      : assert(hour == null || (hour >= 0 && hour < 24)),
        assert(minute == null || (minute >= 0 && minute < 60)),
        assert(second == null || (second >= 0 && second < 60)),
        assert(milliSecond == null || (milliSecond >= 0 && milliSecond < 1000)),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: IntrinsicHeight(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: theme.primaryColor),
      child:
          QudsAnimatedCounter(number, length: length ?? 2, style: this.style),
    );
  }
}
