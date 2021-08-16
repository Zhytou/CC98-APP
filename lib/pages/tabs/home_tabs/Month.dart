import 'package:flutter/material.dart';

import '../../../util/DataUtils.dart';
import '../../../model/Index.dart';
import '../../../widgets/IndexCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class MonthPage extends StatefulWidget {
  MonthPage({Key key}) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  List<Index> _indexes = [];

  getData() {
    DataUtils.getMonthlyHotTopicList().then((result) {
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
