import 'package:flutter/material.dart';

/// Splash screen component with pre-defined components.
class QudsSplashView extends StatefulWidget {
  /// The futures to be executed.
  final List<Future>? futures;

  /// The duration after all futures are executed.
  final Duration durationAfterExecutionFutures;

  /// The logo widget.
  final Widget? logo;

  /// The text under the logo.
  final String? textUnderLogo;

  /// The text style of the text under the logo.
  final TextStyle? textUnderLogoStyle;

  /// Called after  `all futures are executed` + `durationAfterExecutionFutures`
  final Function? onCompleted;

  /// The futures progress indicator widget.
  final Widget? progressIndicator;

  /// Weather to show the progress indicator.
  final bool? showIndicator;

  /// Create an instance of [QudsSplashView]
  const QudsSplashView(
      {Key? key,
      this.futures,
      this.durationAfterExecutionFutures = const Duration(seconds: 1),
      this.progressIndicator,
      this.logo,
      this.textUnderLogo,
      this.textUnderLogoStyle,
      this.onCompleted,
      this.showIndicator = true})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<QudsSplashView> {
  List<Future>? futures;
  Duration? dur;
  @override
  void initState() {
    super.initState();
    var w = widget;
    futures = w.futures;
    dur = w.durationAfterExecutionFutures;

    executeFutures();
  }

  @override
  Widget build(BuildContext context) {
    var w = widget;
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (w.logo != null) ...[
            w.logo!,
            SizedBox(
              height: 10,
            )
          ],
          if (w.textUnderLogo != null) ...[
            Text(w.textUnderLogo!, style: w.textUnderLogoStyle),
            SizedBox(
              height: 10,
            )
          ],
          if (w.showIndicator == true) ...[
            w.progressIndicator ?? CircularProgressIndicator(),
            SizedBox(
              height: 10,
            )
          ]
        ],
      ),
    );
  }

  bool executing = false;
  Future executeFutures() async {
    if (executing) return;

    setState(() {
      executing = true;
    });

    if (futures != null) for (var f in futures!) await f;

    await Future.delayed(widget.durationAfterExecutionFutures);
    widget.onCompleted?.call();

    if (mounted)
      setState(() {
        executing = false;
      });
  }
}
