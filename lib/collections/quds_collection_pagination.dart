import 'package:flutter/material.dart';

/// A widget that show list of items with pagining.
class QudsCollectionPagination<T> extends StatelessWidget {
  /// The current selected page.
  final int selectedPage;

  /// The count of all items.
  final int total;

  /// Desired results count in each page.
  final int resultsPerPage;

  /// The current page items.
  final List<T> currentPageItems;

  /// The builder of each child.
  final Widget Function(
    BuildContext context,
    int index,
    T obj,
  ) itemBuilder;

  /// The divider builder.
  final Widget Function(
    BuildContext context,
    int index,
  )? dividerBuilder;

  /// Called when the current page change.
  final Function(int page) onPageChanged;

  /// Called when the current results per page changed.
  final Function(int resultsPerPage)? onResultsPerPageChanged;

  /// The desired page items counts like `[ 5 , 10 , 20 ]`
  final List<int> pageItemLengths;

  /// The items cross axis alignment.
  final CrossAxisAlignment crossAxisAlignment;

  /// The items listview padding.
  final EdgeInsets? itemsPadding;

  /// Create an instance of [QudsCollectionPagination].
  const QudsCollectionPagination(
      {required this.selectedPage,
      required this.currentPageItems,
      required this.itemBuilder,
      this.dividerBuilder,
      required this.onPageChanged,
      this.onResultsPerPageChanged,
      this.resultsPerPage = 5,
      this.pageItemLengths = const [5, 10, 20, 30, 50, 100],
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.itemsPadding,
      required this.total,
      Key? key})
      : assert(selectedPage >= 1),
        assert(total >= 0),
        assert(resultsPerPage > 0),
        super(key: key);

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
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  _buildPagesControls(context),
                  _buildResultsStatistics(context),
                ],
              ),
            ),
          )
        : SizedBox(
            height: double.infinity,
            child: Material(
              elevation: 3,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    _buildPagesControls(context),
                    _buildResultsStatistics(context),
                  ],
                ),
              ),
            ));
  }

  /// Get the number of all pages.
  int get _totalPages {
    var result = total ~/ resultsPerPage;
    if (result * resultsPerPage < total) result += 1;
    return result;
  }

  Widget _buildPagesControls(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (total == 0) return Container();

    List<int> pages = [];

    Null Function(int i) addPage;
    addPage = (int i) {
      if (pages.length < 5 && !pages.contains(i) && i > 0 && i <= _totalPages) {
        pages.add(i);
      }
    };

    addPage(1);
    addPage(_totalPages);
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
      if (i == 0) {
        widgetNums.add(_buildNumButton(pages[i], context));
      } else {
        if (pages[i - 1] != pages[i] - 1) {
          widgetNums.add(_buildNumButton(null, context));
          widgetNums.add(_buildNumButton(pages[i], context));
        } else {
          widgetNums.add(_buildNumButton(pages[i], context));
        }
      }
    }
    for (int i = 1; i <= pages.length; i++) {}
    //Temp
    var result = isPortrait
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetNums.isEmpty ? [] : widgetNums,
            ),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgetNums.isEmpty ? [] : widgetNums,
            ),
          );

    return Container(
      margin: const EdgeInsets.all(4),
      child: result,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.black26)]),
    );
  }

  Widget _buildNumButton(int? i, BuildContext context) {
    var style = Theme.of(context).textTheme.bodyText1!;
    var border = BorderRadius.circular(3);
    return Material(
      borderRadius: border,
      // elevation: i == null ? 0 : 3,
      child: InkWell(
        customBorder: RoundedRectangleBorder(borderRadius: border),
        child: Container(
          child: Text(i == null ? '...' : i.toString(),
              style: i == selectedPage
                  ? style.copyWith(
                      height: 0.8, fontWeight: FontWeight.bold, fontSize: 30)
                  : style),
          padding: const EdgeInsets.all(10),
        ),
        onTap: i == null ? null : () => onPageChanged.call(i),
      ),
    );
  }

  Widget _buildResultsStatistics(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var style = const TextStyle(fontSize: 18);

    var result = Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
                  Text(
                    ((selectedPage - 1) * resultsPerPage + 1).toString() +
                        ' - ' +
                        ((selectedPage - 1) * resultsPerPage +
                                currentPageItems.length)
                            .toString(),
                    style: style,
                  ),
                  Text(
                    isPortrait ? ' \\ ' : 'ــــ',
                    style: style.copyWith(
                        height: isPortrait ? null : 0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    total.toString(),
                    style: style,
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
                height: 15,
              ),
              Row(
                children: <Widget>[
                  DropdownButton<int>(
                    value: resultsPerPage,
                    items: pageItemLengths
                        .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem<int>(
                                  child: Text(
                                    e.toString(),
                                    style: const TextStyle(
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
                const Divider(
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
