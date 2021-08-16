import 'package:flutter/material.dart';

import '../model/Post.dart';

String getTopicPostTime(String time) {
  if (time == null) {
    return '';
  }
  List<String> postTimes = time.split('T');
  String monthAndDay = postTimes[0].substring(2);
  List<String> hourAndMinute = postTimes[1].split(':');
  return monthAndDay + ' ' + hourAndMinute[0] + ':' + hourAndMinute[1];
}

class UserReplyCell extends StatelessWidget {
  final Message _messageInfo;
  UserReplyCell(this._messageInfo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 3, right: 10, left: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 3),
                child: Text(
                    _messageInfo.title == '签到回复'
                        ? _messageInfo.title
                        : _messageInfo.content,
                    style: TextStyle(fontSize: 17)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.access_time, color: Colors.pink, size: 18),
                  Text(
                    _messageInfo == null || _messageInfo.time == null
                        ? ''
                        : getTopicPostTime(_messageInfo.time),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Icon(Icons.thumb_up_outlined, color: Colors.indigo, size: 18),
                  Text(
                    _messageInfo == null || _messageInfo.likeCount == null
                        ? ''
                        : _messageInfo.likeCount.toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
