import 'package:flutter/material.dart';

import '../model/Index.dart';
import '../routers/Application.dart';

String getTopicPostTime(String time) {
  if (time == null) {
    return '';
  }
  List<String> postTimes = time.split('T');
  String monthAndDay = postTimes[0].substring(2);
  List<String> hourAndMinute = postTimes[1].split(':');
  return monthAndDay + ' ' + hourAndMinute[0] + ':' + hourAndMinute[1];
}

class UserTopicCell extends StatelessWidget {
  final Topic _topicInfo;
  UserTopicCell(this._topicInfo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            '/topic?id=${_topicInfo.id}&title=${Uri.encodeComponent(_topicInfo?.title)}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 3, right: 10, left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 2, bottom: 3),
              child: Text(_topicInfo.title, style: TextStyle(fontSize: 16)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context) {
                  if (_topicInfo.boardName != null)
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.app_registration,
                            color: Colors.lightBlue, size: 18),
                        Text(_topicInfo.boardName,
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ],
                    );
                  else
                    return Container();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.access_time, color: Colors.pink, size: 18),
                    Text(
                      _topicInfo == null || _topicInfo.time == null
                          ? ''
                          : getTopicPostTime(_topicInfo.time),
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Icon(Icons.messenger_outline_rounded,
                        color: Colors.indigo, size: 18),
                    Text(
                      _topicInfo == null || _topicInfo.replyCount == null
                          ? ''
                          : _topicInfo.replyCount.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
