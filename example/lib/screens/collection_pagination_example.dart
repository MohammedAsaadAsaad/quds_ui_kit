import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class CollectionPaginationExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CollectionPaginationExample> {
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
        title: Text('Collection Pagination Example'),
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
    for (int i = 1; i <= 253; i++)
      list.add(_ExampleModel(i, 'name: ' + i.toString()));
  }

  List<_ExampleModel> getPageItems(int page, int itemsPerPage) {
    int start = (page - 1) * itemsPerPage;
    return list
        .getRange(start, min(start + itemsPerPage, list.length))
        .toList();
  }
}
