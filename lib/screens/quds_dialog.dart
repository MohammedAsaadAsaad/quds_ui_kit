import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quds_ui_kit/animations/quds_animations.dart';

Future<void> showQudsConfirmDeleteDialog(BuildContext context,
    {Widget? child = const Text('Are you sure to delete?'),
    Widget Function(BuildContext context)? builder,
    EdgeInsets insetPadding = _defaultDialogInsetPadding,
    String? title = 'Delete',
    AlignmentGeometry alignment = Alignment.center,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    String deleteText = 'Delete',
    String cancelText = 'Cancel',
    Function? onDeletePressed,
    Function? onCancelPressed}) async {
  await showQudsYesNoDialog(context,
      child: child,
      builder: builder,
      insetPadding: insetPadding,
      title: title == null ? null : Text(title),
      leadingActions: [
        QudsAutoAnimatedCombinedIcons(
          startIcon: Icons.info_outline,
          endIcon: Icons.delete_outlined,
          endIconColor: Colors.red,
        )
      ],
      alignment: alignment,
      backgroundColor: backgroundColor,
      onYesPressed: onDeletePressed,
      onNoPressed: onCancelPressed,
      yesColor: Colors.red,
      yesText: deleteText,
      noText: cancelText);
}

Future<void> showQudsConfirmExitDialog(BuildContext context,
    {Widget? child = const Text('Are you sure to exit?'),
    Widget Function(BuildContext context)? builder,
    EdgeInsets insetPadding = _defaultDialogInsetPadding,
    String? title = 'Exit',
    AlignmentGeometry alignment = Alignment.center,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    String exitText = 'Exit',
    String cancelText = 'Cancel',
    Function? onExitPressed,
    Function? onCancelPressed}) async {
  await showQudsYesNoDialog(context,
      child: child,
      builder: builder,
      insetPadding: insetPadding,
      title: title == null ? null : Text(title),
      leadingActions: [
        QudsAutoAnimatedCombinedIcons(
          startIcon: Icons.info_outline,
          endIcon: Icons.exit_to_app_rounded,
          endIconColor: Colors.red,
        )
      ],
      alignment: alignment,
      backgroundColor: backgroundColor,
      onYesPressed: onExitPressed,
      onNoPressed: onCancelPressed,
      yesColor: Colors.red,
      yesText: exitText,
      noText: cancelText);
}

Future<void> showQudsYesNoDialog(BuildContext context,
    {Widget? child,
    Widget Function(BuildContext context)? builder,
    EdgeInsets insetPadding = _defaultDialogInsetPadding,
    Widget? title,
    List<Widget>? leadingActions,
    AlignmentGeometry alignment = Alignment.center,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    String yesText = 'Yes',
    String noText = 'No',
    Color? yesColor,
    Color? noColor,
    Function? onYesPressed,
    Function? onNoPressed}) async {
  var result = await showQudsDialog(context,
      child: child,
      builder: builder,
      insetPadding: insetPadding,
      title: title,
      leadingActions: leadingActions,
      alignment: alignment,
      backgroundColor: backgroundColor,
      actions: [
        TextButton(
            style: yesColor == null
                ? null
                : ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(yesColor)),
            onPressed: () {
              Navigator.pop(context, 'yes');
            },
            child: Text(yesText)),
        TextButton(
            style: noColor == null
                ? null
                : ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(noColor)),
            onPressed: () {
              Navigator.pop(context, 'no');
            },
            child: Text(noText)),
      ]);
  switch (result) {
    case 'yes':
      onYesPressed?.call();
      break;
    case 'no':
      onNoPressed?.call();
      break;
  }
}

Future<T?> showQudsDialog<T>(BuildContext context,
    {Widget? child,
    Widget Function(BuildContext context)? builder,
    EdgeInsets insetPadding = _defaultDialogInsetPadding,
    Widget? title,
    List<Widget>? actions,
    List<Widget>? leadingActions,
    AlignmentGeometry alignment = Alignment.center,
    Color? backgroundColor,
    BorderRadius? borderRadius}) async {
  return await showDialog<T>(
      context: context,
      builder: (c) => QudsDialog(
          child: child ?? (builder == null ? null : builder(context)),
          insetPadding: insetPadding,
          actions: actions,
          alignment: alignment,
          leadingActions: leadingActions,
          title: title,
          borderRadis: borderRadius,
          backgroundColor: backgroundColor));
}

const EdgeInsets _defaultDialogInsetPadding =
    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);
final BorderRadius _defaultDialogBorderRadius = BorderRadius.circular(4);

class QudsDialog extends StatelessWidget {
  final EdgeInsets insetPadding;
  final Widget? child;
  final List<Widget>? actions;
  final List<Widget>? leadingActions;
  final Widget? title;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadis;
  final Color? backgroundColor;

  const QudsDialog(
      {Key? key,
      this.child,
      this.title,
      this.alignment = Alignment.center,
      this.insetPadding = _defaultDialogInsetPadding,
      this.leadingActions,
      this.borderRadis,
      this.actions,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      alignment: this.alignment,
      padding: this.insetPadding,
      child: Container(
          child: Material(
              color: backgroundColor,
              borderRadius: this.borderRadis ?? _defaultDialogBorderRadius,
              child: SafeArea(
                  child: Container(
                padding: EdgeInsets.all(10),
                child: IntrinsicWidth(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leadingActions != null || title != null) ...[
                      Row(
                        children: [
                          if (leadingActions != null) ...[
                            ...leadingActions!,
                            SizedBox(
                              width: 5,
                            )
                          ],
                          if (title != null)
                            DefaultTextStyle(
                                style: theme.textTheme.headline5!,
                                child: title!),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                    child ?? Container(),
                    if (actions != null) ...[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [...actions!],
                          ))
                    ]
                  ],
                )),
              )))),
    );
  }
}
