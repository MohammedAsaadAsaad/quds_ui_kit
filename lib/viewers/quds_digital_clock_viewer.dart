import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/animations/quds_animated_text.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class QudsDigitalClockViewer extends StatefulWidget {
  final bool showHour;
  final bool showMinute;
  final bool showSeconds;
  final bool showMilliSeconds;
  final bool format24;
  final bool showTimePeriod;
  final TextStyle style;
  final TextStyle timePerionStyle;
  final String amText;
  final String pmText;

  const QudsDigitalClockViewer(
      {Key? key,
      this.showHour = true,
      this.showMinute = true,
      this.showSeconds = false,
      this.showMilliSeconds = false,
      this.format24 = true,
      this.showTimePeriod = true,
      this.style = const TextStyle(fontSize: 18, color: Colors.white),
      this.timePerionStyle = const TextStyle(fontSize: 18),
      this.amText = 'AM',
      this.pmText = 'PM'})
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
    bool isMorning = t.hour < 12;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showTimePeriod) ...[
              QudsAnimatedText(
                isMorning ? widget.amText : widget.pmText,
                style: widget.timePerionStyle,
              ),
              SizedBox(
                width: 5,
              )
            ],
            QudsDigitalTimeViewer(
              format24: widget.format24,
              hour: widget.showHour ? t.hour : null,
              minute: widget.showMinute ? t.minute : null,
              second: widget.showSeconds ? t.second : null,
              milliSecond: widget.showMilliSeconds ? t.millisecond : null,
              style: widget.style,
            )
          ],
        ));
  }

  @override
  void dispose() {
    _tmrUpdater.cancel();
    super.dispose();
  }
}
