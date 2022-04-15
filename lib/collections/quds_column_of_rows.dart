import 'dart:math';
import 'package:flutter/widgets.dart';

/// Represents a [Column] of [Row]s
class QudsColumnOfRows extends StatelessWidget {
  /// Collection of items
  final List<Widget> items;

  /// Items main axis alignment for each row
  final MainAxisAlignment? rowMainAxisAlignment;

  /// Items cross axis alignment for each row
  final CrossAxisAlignment? rowCrossAxisAlignment;

  /// The column main axis alignment.
  final MainAxisAlignment? columnMainAxisAlignment;

  /// The column cross axis alignment.
  final CrossAxisAlignment? columnCrossAxisAlignment;

  /// The desired items count per each row.
  final int itemsPerRow;

  /// The rows seperator divider hight.
  final double rowsSeperatorValue;

  /// The column main axis size.
  final MainAxisSize? columnMainAxisSize;

  /// The rows divider builder, if null, the divider will be an instance of [Divider]
  final Widget Function(BuildContext context)? seperatorBuilder;

  /// Create an instance of [QudsColumnOfRows]
  const QudsColumnOfRows(
      {required this.items,
      required this.itemsPerRow,
      this.rowMainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.rowCrossAxisAlignment = CrossAxisAlignment.center,
      this.rowsSeperatorValue = 10,
      this.columnCrossAxisAlignment,
      this.columnMainAxisAlignment,
      this.columnMainAxisSize = MainAxisSize.min,
      this.seperatorBuilder,
      Key? key})
      : assert(itemsPerRow > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemsTemp = items.toList();

    List<Row> rows = [];
    while (itemsTemp.isNotEmpty) {
      var start = 0;
      var end = min(itemsTemp.length, itemsPerRow);
      rows.add(Row(
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment:
            rowMainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        children: itemsTemp.getRange(start, end).toList(),
      ));
      itemsTemp.removeRange(start, end);
    }
    return Column(
      mainAxisSize: columnMainAxisSize ?? MainAxisSize.min,
      children: rows
          .map((e) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  e,
                  if (e != rows.last)
                    seperatorBuilder != null
                        ? seperatorBuilder!(context)
                        : SizedBox(
                            height: rowsSeperatorValue,
                          )
                ],
              ))
          .toList(),
    );
  }
}
