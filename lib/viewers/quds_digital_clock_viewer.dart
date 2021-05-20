import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsDigitalClockViewer extends StatefulWidget {
  final bool showHour;
  final bool showMinute;
  final bool showSeconds;
  final bool showMilliSeconds;
  final bool format24;
  final bool showTimePeriod;
  final TextStyle style;
  final TextStyle timePeriodStyle;
  final String amText;
  final String pmText;
  final Color? backgroundColor;

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
      timePerionStyle: widget.timePeriodStyle,
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
