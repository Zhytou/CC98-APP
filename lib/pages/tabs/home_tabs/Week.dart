import 'package:flutter/material.dart';

import '../../../util/DataUtils.dart';
import '../../../model/Index.dart';
import '../../../widgets/IndexCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class WeekPage extends StatefulWidget {
  WeekPage({Key key}) : super(key: key);

  @override
  _WeekPageState createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  List<Index> _indexes = [];

  getData() {
    DataUtils.getWeeklyHotTopicList().then((result) {
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
