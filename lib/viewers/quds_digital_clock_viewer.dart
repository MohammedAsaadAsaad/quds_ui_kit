import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

/// A live digital clock viewer with digits flipping effect.
class QudsDigitalClockViewer extends StatefulWidget {
  /// Weather to show the hours component.
  final bool showHour;

  /// Weather to show the minutes component.
  final bool showMinute;

  /// Weather to show the seconds component.
  final bool showSeconds;

  /// Weather to show the milliseconds component.
  final bool showMilliSeconds;

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

  /// Create an instance of [QudsDigitalClockViewer]
  const QudsDigitalClockViewer(
      {Key? key,
      this.showHour = true,
      this.showMinute = true,
      this.showSeconds = false,
      this.showMilliSeconds = false,
      this.format24 = true,
      this.showTimePeriod = true,
      this.style = const TextStyle(fontSize: 18, color: Colors.white),
      this.timePeriodStyle = const TextStyle(fontSize: 18),
      this.amText = 'AM',
      this.pmText = 'PM',
      this.backgroundColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QudsDigitalClockViewer> {
  late Timer _tmrUpdater;
  @override
  void initState() {
    _tmrUpdater = Timer.periodic(
        Duration(milliseconds: widget.showMilliSeconds ? 45 : 1000), (timer) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = DateTime.now();
    return QudsDigitalTimeViewer(
      backgroundColor: widget.backgroundColor,
      showTimePeriod: widget.showTimePeriod,
      timePeriodStyle: widget.timePeriodStyle,
      amText: widget.amText,
      pmText: widget.pmText,
      format24: widget.format24,
      hour: widget.showHour ? t.hour : null,
      minute: widget.showMinute ? t.minute : null,
      second: widget.showSeconds ? t.second : null,
      milliSecond: widget.showMilliSeconds ? t.millisecond : null,
      style: widget.style,
    );
  }

  @override
  void dispose() {
    _tmrUpdater.cancel();
    super.dispose();
  }
}
