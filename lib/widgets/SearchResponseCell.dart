import 'package:flutter/material.dart';

import '../routers/Application.dart';
import '../model/Index.dart';

String getTopicPostTime(String time) {
  if (time == null) {
    return '';
  }
  List<String> postTimes = time.split('T');
  String monthAndDay = postTimes[0].substring(2);
  List<String> hourAndMinute = postTimes[1].split(':');
  return monthAndDay + ' ' + hourAndMinute[0] + ':' + hourAndMinute[1];
}

class SearchResponseCell extends StatelessWidget {
  SearchResponseCell(this._topicInfo);
  final Topic _topicInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            '/topic?id=${_topicInfo.id}&title=${Uri.encodeComponent(_topicInfo?.title)}');
      },
      child: Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_topicInfo.boardName,
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            Text(_topicInfo.title,
                style: TextStyle(color: Colors.black, fontSize: 15)),
            Row(
              children: [
                Icon(Icons.person_outline, color: Colors.orange, size: 20),
                Text(
                    _topicInfo == null || _topicInfo.userName == null
                        ? ''
                        : _topicInfo.userName,
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Expanded(child: SizedBox()),
                Icon(Icons.access_time, color: Colors.pink, size: 20),
                Text(
                    _topicInfo == null ? '' : getTopicPostTime(_topicInfo.time),
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
                Icon(Icons.messenger_outline_rounded,
                    color: Colors.blue, size: 20),
                Text(
                    _topicInfo == null ? '0' : _topicInfo.replyCount.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
