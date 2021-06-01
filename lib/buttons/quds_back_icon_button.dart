import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

/// An animated back iconButton.
class QudsBackIconButton extends StatelessWidget {
  /// The tooltip message of this button.
  final String? tooltip;

  /// Create an instance of [QudsBackIconButton]
  const QudsBackIconButton({Key? key, this.tooltip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QudsRadianButton(
      tooltip:
          this.tooltip ?? MaterialLocalizations.of(context).backButtonTooltip,
      child: Padding(
          padding: EdgeInsets.all(7),
          child: QudsAutoAnimatedCombinedIcons(
              showStartIcon: false,
              startIcon: Icons.menu,
              endIcon: Icons.arrow_back)),
      onPressed: () => Navigator.pop(context),
    );
  }
}
