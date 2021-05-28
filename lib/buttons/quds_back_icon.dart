import 'package:flutter/material.dart';
import '../quds_ui_kit.dart';

class QudsBackIcon extends StatelessWidget {
  final String tooltip;

  const QudsBackIcon({Key? key, this.tooltip = 'Back'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QudsRadianButton(
      tooltip: this.tooltip,
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
