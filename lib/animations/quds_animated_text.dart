import 'package:flutter/material.dart';

/// A widget shows a flipping text when data is changed.
class QudsAnimatedText extends StatefulWidget {
  /// The string to be viewed.
  final String text;

  /// The duration of the transition between the old and new text.
  final Duration duration;

  /// The text style of the viewed text.
  final TextStyle? style;

  /// [text] the text will be shown, must not be null
  /// [style] the text style of the shown text.
  /// [duration] the duration of the flip transition about old and new text.
  const QudsAnimatedText(this.text,
      {Key? key, this.style, this.duration = const Duration(milliseconds: 200)})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QudsAnimatedText> with TickerProviderStateMixin {
  String _oldText = '';
  String _newText = '';
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.duration)
      ..addListener(_refresh)
      ..forward(from: 0);
    _newText = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    var tStyle = widget.style ?? DefaultTextStyle.of(context).style;
    var tSize = tStyle.fontSize ?? DefaultTextStyle.of(context).style.fontSize!;
    if (_newText != widget.text) {
      _oldText = _newText;
      _newText = widget.text;
      _animationController.duration = widget.duration;
      _animationController.forward(
        from: 0,
      );
    }
    double v = _animationController.value;
    Widget tNew = Text(_newText, overflow: TextOverflow.visible, style: tStyle);
    Widget tOld = Text(_oldText, style: tStyle);

    var tpNew = Positioned(
        bottom: (1 - v) * tSize,
        child: Opacity(
          opacity: v,
          child: tNew,
        ));

    var tpOld = Positioned(
        top: -v * tSize,
        child: Opacity(
          opacity: 1 - v,
          child: tOld,
        ));

    var result = Stack(
      children: [
        tpNew,
        tpOld,
        Opacity(opacity: 0, child: tNew),
        Opacity(opacity: 0, child: tOld)
      ],
    );

    return Container(
      child: Center(
        child: result,
      ),
    );
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _animationController.removeListener(_refresh);
    _animationController.dispose();
    super.dispose();
  }
}
