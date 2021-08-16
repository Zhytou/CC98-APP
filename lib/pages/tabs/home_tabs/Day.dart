import 'package:flutter/material.dart';

import '../../../util/DataUtils.dart';
import '../../../model/Index.dart';
import '../../../widgets/IndexCell.dart';
import '../../../widgets/AutoPlayCell.dart';
import '../../../widgets/LoadMoreCell.dart';

class DayPage extends StatefulWidget {
  DayPage({Key key}) : super(key: key);

  @override
  _DayPageState createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  List<Index> _indexes = [];
  List<Topic> _recommendations = [];

  int _todayTopicCount = 0;
  int _todayCount = 0;
  int _topicCount = 0;
  int _postCount = 0;
  int _onlineUserCount = 0;

  int _userCount = 0;
  String _userName = '';
  //String _announcement = '';

  getData() {
    DataUtils.getForumInfo().then((result) {
      setState(() {
        _indexes = result.hotTopics;
        _recommendations = result.recommendations;

        _todayCount = result.todayCount;
        _todayTopicCount = result.todayTopicCount;

        _topicCount = result.topicCount;
        _postCount = result.postCount;
        _onlineUserCount = result.onlineUserCount;

        _userCount = result.userCount;
        _userName = result.userName;
        //_announcement = result.announcement;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  forumStatistic() {
    return Container(
      height: 180,
      padding: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '论坛统计',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('今日贴数：' + _todayCount.toString()),
          Text('今日主题数：' + _todayTopicCount.toString()),
          Text('论坛总主题数：' + _topicCount.toString()),
          Text('论坛总回复数：' + _postCount.toString()),
          Text('在线用户数：' + _onlineUserCount.toString()),
          Text('总用户数：' + _userCount.toString()),
          Text('欢迎新用户：' + _userName),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, num) {
          if (_indexes.isNotEmpty) {
            if (num < _indexes?.length)
              return IndexCell(
                this._indexes[num].topic,
                this._indexes[num].user,
                this._indexes[num].board,
              );
            else
              return SizedBox(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoPlayCell(_recommendations),
                    forumStatistic(),
                  ],
                ),
              );
          } else
            return LoadMoreCell();
        },
        separatorBuilder: (context, num) {
          return Divider(thickness: 2);
        },
        itemCount:
            _indexes == null || _indexes.isEmpty ? 1 : (_indexes.length + 1));
  }
}
