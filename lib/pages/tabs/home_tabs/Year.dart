import 'package:flutter/material.dart';

import '../../../util/DataUtils.dart';
import '../../../model/Index.dart';
import '../../../widgets/IndexCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class YearPage extends StatefulWidget {
  YearPage({Key key}) : super(key: key);

  @override
  _YearPageState createState() => _YearPageState();
}

class _YearPageState extends State<YearPage> {
  List<Index> _indexes = [];

  getData() {
    DataUtils.getHistoryHotTopicList().then((result) {
      setState(() {
        _indexes = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _indexes.isEmpty ? 1 : _indexes.length,
      itemBuilder: (context, num) {
        if (_indexes.isNotEmpty)
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
    );
  }
}
