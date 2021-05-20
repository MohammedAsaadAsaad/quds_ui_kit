import 'dart:math';
import 'package:flutter/widgets.dart';

/// [Column] of [Row]s
class QudsColumnOfRows extends StatelessWidget {
  /// Collection of items
  final List<Widget> items;

  /// Items main axis alignment for each row
  final MainAxisAlignment? rowMainAxisAlignment;

  /// Items cross axis alignment for each row
  final CrossAxisAlignment? rowCrossAxisAlignment;

  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final int itemsPerRow;
  final double rowsSeperatorValue;
  final MainAxisSize? columnMainAxisSize;
  final Widget Function(BuildContext context)? seperatorBuilder;

  QudsColumnOfRows(
      {required this.items,
      required this.itemsPerRow,
      this.rowMainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.rowCrossAxisAlignment = CrossAxisAlignment.center,
      this.rowsSeperatorValue = 10,
      this.columnCrossAxisAlignment,
      this.columnMainAxisAlignment,
      this.columnMainAxisSize = MainAxisSize.min,
      this.seperatorBuilder})
      : assert(itemsPerRow > 0);

  @override
  Widget build(BuildContext context) {
    var itemsTemp = items.toList();

    List<Row> rows = [];
    while (itemsTemp.length > 0) {
      var start = 0;
      var end = min(itemsTemp.length, itemsPerRow);
      rows.add(Row(
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment:
            this.rowMainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        children: itemsTemp.getRange(start, end).toList(),
      ));
      itemsTemp.removeRange(start, end);
    }
    return Column(
      mainAxisSize: this.columnMainAxisSize ?? MainAxisSize.min,
      children: rows
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  e,
                  if (e != rows.last)
                    this.seperatorBuilder != null
                        ? this.seperatorBuilder!(context)
                        : SizedBox(
                            height: rowsSeperatorValue,
                          )
                ],
              ))
          .toList(),
    );
  }
}
