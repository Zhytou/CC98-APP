import 'package:flutter/material.dart';

import '../../util/DataUtils.dart';
import '../../model/Index.dart';
import '../../widgets/IndexCell.dart';
import '../../widgets/LoadMoreCell.dart';
import '../../widgets/FloatingButtonCell.dart';

class NewPage extends StatefulWidget {
  NewPage({Key key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  ScrollController _controller;

  Map<String, dynamic> _params;
  List<Index> _indexes = [];

  getData() {
    DataUtils.getNewTopicList(_params).then((resultList) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('全站最新主题'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshView,
        child: ListView.separated(
          controller: _controller,
          itemCount: _indexes == null ? 0 : _indexes.length + 1,
          itemBuilder: (context, num) {
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
      ),
      floatingActionButton: FloatingButtonCell(),
    );
  }
}
