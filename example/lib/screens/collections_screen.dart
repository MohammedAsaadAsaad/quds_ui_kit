import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class CollectionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CollectionsScreen> {
  int page = 1;
  int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    _fillItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections'),
      ),
      body: _buildBody(),
    );
  }

  _ExampleCollectionProvider provider = _ExampleCollectionProvider();
  List<_ExampleModel> currItems = [];
  void _fillItems() {
    currItems.clear();
    currItems.addAll(provider.getPageItems(page, itemsPerPage));

    if (mounted) setState(() {});
  }

  Widget _buildBody() {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
                labelColor: Theme.of(context).textTheme.bodyText1!.color,
                tabs: [
                  Tab(
                    text: 'Pagination',
                  ),
                  Tab(
                    text: 'Column of rows',
                  ),
                  Tab(text: 'Animated List View')
                ]),
            Expanded(
                child: Container(
              child: TabBarView(
                children: [
                  _buildPagining(),
                  _buildColumnOfRows(),
                  _buildAnimatedListView()
                ],
              ),
            ))
          ],
        ));
  }

  Widget _buildPagining() {
    return Container(
      child: QudsCollectionPagination<_ExampleModel>(
        resultsPerPage: itemsPerPage,
        itemsPadding: EdgeInsets.all(2),
        onResultsPerPageChanged: (p) {
          page = 1;
          itemsPerPage = p;
          _fillItems();
        },
        currentPageItems: currItems,
        onPageChanged: (p) {
          page = p;
          _fillItems();
        },
        selectedPage: page,
        total: provider.list.length,
        itemBuilder: (c, i, o) => ListTile(
          title: Text(o.name),
          subtitle: Text(o.id.toString()),
        ),
      ),
    );
  }

  Widget _buildColumnOfRows() {
    return LayoutBuilder(builder: (c, cs) {
      double dim = 100;
      int itemsPerRow = cs.maxWidth ~/ dim;
      dim = cs.maxWidth / itemsPerRow;

      Widget result = QudsColumnOfRows(items: [
        for (int i = 0; i < 30; i++)
          Container(
            width: dim,
            child: Container(
                child: Card(
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Center(child: Text(i.toString()))))),
          )
      ], itemsPerRow: itemsPerRow);
      result = SingleChildScrollView(
        child: result,
      );
      return result;
    });
  }

  Widget _buildAnimatedListView() {
    return QudsAnimatedListView(
      // slideDirection: SlideDirection.Start,
      children: [
        for (int i = 0; i < 100; i++)
          ListTile(
            leading: Icon(Icons.redeem),
            title: Text(i.toString()),
            subtitle: Text('$i$i$i'),
          )
      ],
    );
  }
}

class _ExampleModel {
  final String name;
  final int id;

  const _ExampleModel(this.id, this.name);
}

class _ExampleCollectionProvider {
  List<_ExampleModel> list = [];
  _ExampleCollectionProvider() {
    //Fill with test models
    for (int i = 1; i <= 100; i++)
      list.add(_ExampleModel(i, 'name: ' + i.toString()));
  }

  List<_ExampleModel> getPageItems(int page, int itemsPerPage) {
    int start = (page - 1) * itemsPerPage;
    return list
        .getRange(start, min(start + itemsPerPage, list.length))
        .toList();
  }
}
