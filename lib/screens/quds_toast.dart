import 'package:flutter/material.dart';

/// Show customizable buatiful toast.
Future showQudsToast(BuildContext context,
    {MainAxisAlignment alignment = MainAxisAlignment.center,
    Widget? content,
    List<Widget>? leadingActions,
    List<Widget>? trailingActions,
    Color? backgroundColor,
    Color? shadowColor,
    Duration? displayDuration,
    QudsToastTime? toastTime = QudsToastTime.Normal}) async {
  var theme = Theme.of(context);
  var backColor = backgroundColor ?? theme.primaryColor.withOpacity(0.75);
  var shColor = shadowColor ?? Colors.black54;
  Widget snackContent = Row(
    mainAxisAlignment: alignment,
    children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: shColor, blurRadius: 5)],
              color: backColor),
          child: Material(
              color: Colors.transparent,
              child: Container(
                  padding: EdgeInsets.all(6),
                  child: IntrinsicHeight(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leadingActions != null) ...[
                        ...leadingActions,
                        const SizedBox(
                          width: 5,
                        )
                      ],
                      DefaultTextStyle(
                          style: theme.primaryTextTheme.bodyText1!
                              .copyWith(fontSize: 18),
                          child: content ??
                              Container(
                                width: 5,
                                height: 5,
                              )),
                      if (trailingActions != null) ...[
                        const SizedBox(
                          width: 5,
                        ),
                        ...trailingActions
                      ],
                    ],
                  )))))
    ],
  );

  snackContent = DefaultTextStyle(
      style: theme.primaryTextTheme.bodyText1!.copyWith(fontSize: 18),
      child: snackContent);

  snackContent = IconTheme(data: theme.primaryIconTheme, child: snackContent);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: displayDuration ??
          _getToastDuration(toastTime) ??
          _getToastDuration(QudsToastTime.Normal)!,
      content: snackContent,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

Duration? _getToastDuration(QudsToastTime? t) {
  if (t == null) return null;
  switch (t) {
    case QudsToastTime.VeryShort:
      return const Duration(milliseconds: 1000);
    case QudsToastTime.Short:
      return const Duration(milliseconds: 2000);
    case QudsToastTime.Normal:
      return const Duration(milliseconds: 3000);
    case QudsToastTime.Long:
      return const Duration(milliseconds: 4000);
    case QudsToastTime.VeryLong:
      return const Duration(milliseconds: 5000);
  }
}

/// The toast period to show.
enum QudsToastTime {
  /// About 1 second.
  VeryShort,

  /// About 2 seconds.
  Short,

  /// About 3 seconds.
  Normal,

  /// About 4 seconds.
  Long,

  /// About 5 seconds.
  VeryLong
}
