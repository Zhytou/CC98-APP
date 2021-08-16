import 'package:flutter/material.dart';

import '../../../model/Index.dart';
import '../../../util/DataUtils.dart';
import '../../../widgets/UserTopicCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class MyBrowsingHistoryPage extends StatefulWidget {
  @override
  _MyBrowsingHistoryPageState createState() => _MyBrowsingHistoryPageState();
}

class _MyBrowsingHistoryPageState extends State<MyBrowsingHistoryPage> {
  List<Topic> _topics = [];

  getData() {
    DataUtils.getMyBrowsingHistory().then((resultList) {
      setState(() {
        _topics = resultList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        appBar: AppBar(),
        body: ListView.separated(
          itemCount: _topics == null ? 0 : _topics.length + 1,
          itemBuilder: (context, num) {
            if (_topics.isNotEmpty)
              return UserTopicCell(_topics[num]);
            else
              return LoadMoreCell();
          },
          separatorBuilder: (context, num) {
            return Divider(thickness: 2);
          },
        ),
      ),
    );
  }
}
