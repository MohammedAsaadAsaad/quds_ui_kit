import 'package:flutter/material.dart';
import 'quds_animated_text.dart';

/// An animating counter, flips automatically when change the number.
class QudsAnimatedCounter extends StatelessWidget {
  /// The current number to be shown.
  final int number;

  /// The length of the viewed number, if it digit less than [length], some zeros will be added.
  final int? length;

  /// The text style of the viewed number.
  final TextStyle? style;

  /// The duration of new numbers transition
  final Duration duration;

  /// [number] the number will be shown in this counter, must be non-negative.
  /// [length] the length of the number (digits count).
  /// [style] the text style of the number.
  /// [duration] the duration of the transition time.
  const QudsAnimatedCounter(
    this.number, {
    Key? key,
    this.length,
    this.style,
    this.duration = const Duration(milliseconds: 200),
  })  : assert(number >= 0, 'Number must be non-negative'),
        assert(length == null || length > 0, 'Length must be positive number'),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    var digits = number.toString().split('');

    while (length != null && digits.length < length!) {
      digits.insert(0, '0');
    }

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var d in digits)
              QudsAnimatedText(
                d.toString(),
                style: style,
                duration: duration,
              )
          ],
        ));
  }
}
