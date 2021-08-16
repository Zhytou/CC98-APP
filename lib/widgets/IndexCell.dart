import 'package:flutter/material.dart';

import '../routers/Application.dart';
import '../model/Index.dart';
import '../model/Board.dart';
import '../model/User.dart';

String getLabelTime(String time) {
  if (time == null)
    return '';
  else {
    const List<String> timeUnits = ['小时前', '分钟前', '秒前'];
    var now = DateTime.now();
    List<String> postTimes = time.split('T');
    List<String> referTimes = now.toString().split(' ');
    if (postTimes[0] == referTimes[0]) {
      List<String> times = postTimes[1].split(':');
      List<String> refers = referTimes[1].split(':');
      for (int i = 0; i < 3; i++) {
        if (times[i] != refers[i]) {
          double res = (double.parse(refers[i]) - double.parse(times[i])).abs();
          return res.round().toString() + timeUnits[i];
        }
      }
    } else
      return postTimes[0];
  }
}

class IndexCell extends StatelessWidget {
  final BasicUser _userInfo;
  final Topic _topicInfo;
  final Board _boardInfo;
  IndexCell(this._topicInfo, this._userInfo, this._boardInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: _topicInfo.isAnonymous ? Colors.blue : Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(_userInfo.portraitUrl),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!_topicInfo.isAnonymous) {
                      if (_topicInfo.userId != null) {
                        Application.router.navigateTo(context,
                            '/user?id=${_topicInfo.userId}&name=${Uri.encodeComponent(_userInfo.name)}');
                      } else if (_topicInfo.authorUserId != null &&
                          _topicInfo.authorUserId != -1) {
                        Application.router.navigateTo(context,
                            '/user?id=${_topicInfo.authorUserId}&name=${Uri.encodeComponent(_userInfo.name)}');
                      }
                    }
                  },
                  child: Text(
                    _userInfo?.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    if (_boardInfo == null)
                      Application.router.navigateTo(context,
                          '/board?id=${_topicInfo?.boardId}&name=${Uri.encodeComponent(_topicInfo?.boardName)}');
                    else
                      Application.router.navigateTo(context,
                          '/board?id=${_boardInfo?.id}&name=${Uri.encodeComponent(_boardInfo?.name)}');
                  },
                  child: Text(
                    _topicInfo?.boardName == null
                        ? (_boardInfo == null || _boardInfo.name == null
                            ? ''
                            : _boardInfo?.name)
                        : _topicInfo.boardName,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: InkWell(
              onTap: () {
                Application.router.navigateTo(context,
                    '/topic?id=${_topicInfo.id}&title=${Uri.encodeComponent(_topicInfo?.title)}');
              },
              child: Text(
                _topicInfo.title,
                style: TextStyle(fontSize: 17),
              ),
            ),
            alignment: Alignment(-1, 0),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  _topicInfo.replyCount.toString() +
                      '回复 · ' +
                      _topicInfo.hitCount.toString() +
                      '浏览',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Expanded(child: SizedBox()),
                Text(
                  getLabelTime(_topicInfo.lastPostTime),
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
