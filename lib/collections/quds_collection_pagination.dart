import 'package:flutter/material.dart';

/// A widget that show list of items with pagining.
class QudsCollectionPagination<T> extends StatelessWidget {
  final int selectedPage;
  final int total;
  final int resultsPerPage;
  final List<T> currentPageItems;
  final Widget Function(
    BuildContext context,
    int index,
    T obj,
  ) itemBuilder;
  final Widget Function(
    BuildContext context,
    int index,
  )? dividerBuilder;
  final Function(int page) onPageChanged;
  final Function(int resultsPerPage)? onResultsPerPageChanged;
  final List<int> pageItemLengths;
  final String resultsText;
  final String ofText;
  final String resultsPerPageText;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsets? itemsPadding;

  QudsCollectionPagination(
      {required this.selectedPage,
      required this.currentPageItems,
      required this.itemBuilder,
      this.dividerBuilder,
      required this.onPageChanged,
      this.onResultsPerPageChanged,
      this.resultsPerPage = 5,
      this.pageItemLengths = const [5, 10, 20, 30, 50, 100],
      this.resultsText = 'Results',
      this.ofText = 'of',
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.resultsPerPageText = 'Results per page',
      this.itemsPadding,
      required this.total})
      : assert(selectedPage >= 1),
        assert(total >= 0),
        assert(resultsPerPage > 0);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    var listView = Scrollbar(
      child: ListView(
        children: <Widget>[
          if (isPortrait) _buildNavigationControls(context),
          _buildItemsList(context)
        ],
      ),
    );
    return isPortrait
        ? listView
        : Row(
            children: [
              _buildNavigationControls(context),
              Expanded(child: listView)
            ],
          );
  }

  Widget _buildNavigationControls(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return isPortrait
        ? Material(
            elevation: 3,
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  buildPagesControls(context),
                  buildResultsStatistics(context),
                ],
              ),
            ),
          )
        : Container(
            height: double.infinity,
            child: Material(
              elevation: 3,
              child: Container(
                height: double.infinity,
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    buildPagesControls(context),
                    buildResultsStatistics(context),
                  ],
                ),
              ),
            ));
  }

  int get totalPages {
    var result = total ~/ resultsPerPage;
    if (result * resultsPerPage < total) result += 1;
    return result;
  }

  Widget buildPagesControls(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (total == 0) return Container();

    List<int> pages = [];

    var addPage = (int i) {
      if (pages.length < 5 && !pages.contains(i) && i > 0 && i <= totalPages)
        pages.add(i);
    };

    addPage(1);
    addPage(totalPages);
    addPage(selectedPage);
    addPage(selectedPage - 1);
    addPage(selectedPage + 1);
    addPage(selectedPage - 2);
    addPage(selectedPage + 2);
    addPage(selectedPage - 3);
    addPage(selectedPage + 3);

    pages.sort((a, b) => a.compareTo(b));

    List<Widget> widgetNums = [];
    for (int i = 0; i < pages.length; i++) {
      if (i == 0)
        widgetNums.add(buildNumButton(pages[i], context));
      else {
        if (pages[i - 1] != pages[i] - 1) {
          widgetNums.add(buildNumButton(null, context));
          widgetNums.add(buildNumButton(pages[i], context));
        } else
          widgetNums.add(buildNumButton(pages[i], context));
      }
    }
    for (int i = 1; i <= pages.length; i++) {}
    //Temp
    return isPortrait
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetNums.length <= 0 ? [] : widgetNums,
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetNums.length <= 0 ? [] : widgetNums,
            ),
          );
  }

  Widget buildNumButton(int? i, BuildContext context) {
    var style = Theme.of(context).textTheme.bodyText1!;
    var border = BorderRadius.circular(3);
    return Container(
      padding: EdgeInsets.all(i == null ? 0 : 5),
      child: Material(
        borderRadius: border,
        elevation: i == null ? 0 : 3,
        child: InkWell(
          customBorder: RoundedRectangleBorder(borderRadius: border),
          child: Container(
            child: Text(i == null ? '...' : i.toString(),
                style: i == selectedPage
                    ? style.copyWith(fontWeight: FontWeight.bold, fontSize: 30)
                    : style),
            padding: EdgeInsets.all(10),
          ),
          onTap: i == null ? null : () => onPageChanged.call(i),
        ),
      ),
    );
  }

  Widget buildResultsStatistics(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var style = TextStyle(fontSize: 18);

    var result = Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
          scrollDirection: isPortrait ? Axis.horizontal : Axis.vertical,
          child: Container(
              child: _widgetsCollection(
            isRow: isPortrait,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _widgetsCollection(
                isRow: isPortrait,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isPortrait)
                    Text(
                      resultsText + ': ',
                      style: style.copyWith(fontWeight: FontWeight.bold),
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    ((selectedPage - 1) * resultsPerPage + 1).toString() +
                        ' - ' +
                        ((selectedPage - 1) * resultsPerPage +
                                currentPageItems.length)
                            .toString(),
                    style: style,
                  ),
                  Text(
                    '  $ofText  ',
                    style: style.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total.toString(),
                    style: style,
                  ),
                ],
              ),
              SizedBox(
                width: 15,
                height: 15,
              ),
              Row(
                children: <Widget>[
                  if (isPortrait)
                    Text(
                      resultsPerPageText + ': ',
                      style: TextStyle(fontSize: 14),
                    ),
                  DropdownButton<int>(
                    value: resultsPerPage,
                    items: pageItemLengths
                        .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem<int>(
                                  child: Text(
                                    e.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: e,
                                ))
                        .toList(),
                    onChanged: (value) => onResultsPerPageChanged?.call(value!),
                  )
                ],
              )
            ],
          ))),
    );

    return result;
  }

  Widget _buildItemsList(BuildContext context) {
    var length = currentPageItems.length;
    return Container(
      padding: itemsPadding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          for (var i = 0; i < length; i++) ...[
            itemBuilder(context, i, currentPageItems[i]),
            if (i != length - 1)
              if (dividerBuilder != null)
                dividerBuilder!(context, i)
              else
                Divider(
                  height: 1,
                )
          ]
        ],
      ),
    );
  }

  Widget _widgetsCollection(
          {required List<Widget> children,
          bool isRow = true,
          MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center}) =>
      isRow
          ? Row(
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            )
          : Column(
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            );
}
