import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showQudsToast(BuildContext context,
    {MainAxisAlignment alignment = MainAxisAlignment.center,
    Widget? content,
    List<Widget>? leadingActions,
    List<Widget>? trailingActions,
    Duration? displayDuration,
    QudsToastTime? toastTime = QudsToastTime.Normal}) async {
  var theme = Theme.of(context);
  Widget snackContent = Row(
    mainAxisAlignment: alignment,
    children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)],
              color: theme.primaryColor),
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
                              .copyWith(fontSize: 16),
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
      return Duration(milliseconds: 1000);
    case QudsToastTime.Short:
      return Duration(milliseconds: 2000);
    case QudsToastTime.Normal:
      return Duration(milliseconds: 3000);
    case QudsToastTime.Long:
      return Duration(milliseconds: 4000);
    case QudsToastTime.VeryLong:
      return Duration(milliseconds: 5000);
  }
}

enum QudsToastTime { VeryShort, Short, Normal, Long, VeryLong }
