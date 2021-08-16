import 'package:flutter/material.dart';

import '../../../model/Index.dart';
import '../../../util/DataUtils.dart';
import '../../../widgets/IndexCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class ConcernUserPage extends StatefulWidget {
  ConcernUserPage({Key key}) : super(key: key);

  @override
  _ConcernUserPageState createState() => _ConcernUserPageState();
}

class _ConcernUserPageState extends State<ConcernUserPage> {
  ScrollController _controller;
  List<Index> _indexes = [];
  Map<String, dynamic> _params;

  getData() {
    DataUtils.getConcernUserTopicList(_params).then((resultList) {
      setState(() {
        _indexes.addAll(resultList);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _params = {'from': 0, 'size': 20};
    getData();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent)
        loadMore();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future refreshView() async {
    _indexes = [];
    _params = {'from': 0, 'size': 20};
    getData();
  }

  Future loadMore() async {
    _params['from'] += _params['size'];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshView,
      child: ListView.separated(
        controller: _controller,
        itemCount: _indexes == null ? 0 : _indexes.length + 1,
        itemBuilder: (conetxt, num) {
          if (_indexes.isNotEmpty && num < _indexes.length)
            return IndexCell(
              this._indexes[num].topic,
              this._indexes[num].user,
              this._indexes[num].board,
            );
          else
            return LoadMoreCell();
        },
        separatorBuilder: (context, num) {
          return Divider(thickness: 2);
        },
      ),
    );
  }
}
