import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html/flutter_html.dart';

import '../model/Post.dart';
import '../model/User.dart';
import '../util/BBCodeConvertUtils.dart';
import '../util/OperationUtils.dart';

import '../routers/Application.dart';

class PostCell extends StatefulWidget {
  PostCell(this._messageInfo, this._userInfo);
  final Message _messageInfo;
  final BasicUser _userInfo;
  @override
  _PostCellState createState() => _PostCellState();
}

class _PostCellState extends State<PostCell> {
  Message _messageInfo;
  BasicUser _userInfo;
  @override
  void initState() {
    super.initState();
    _messageInfo = widget._messageInfo;
    _userInfo = widget._userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 3, bottom: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color:
                        _messageInfo.isAnonymous ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage('' + _userInfo?.portraitUrl),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!_messageInfo.isAnonymous) {
                      Application.router.navigateTo(
                          context, '/user?id=${_messageInfo.userId}}');
                    }
                  },
                  child: Text(
                    _messageInfo.isAnonymous ? '匿名用户' : _messageInfo.userName,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  _messageInfo.floor.toString() + '楼',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            if (_messageInfo.contentType == 1)
              return Container(
                child: MarkdownBody(
                    data: ConvertUtils.bbcode2Markdown(_messageInfo.content)),
                alignment: Alignment(-1, 0),
              );
            else
              return Container(
                child: Html(
                  data: ConvertUtils.bbcode2Html(_messageInfo.content),
                ),
                alignment: Alignment(-1, 0),
              );
          }),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.settings, color: Colors.grey, size: 20),
                      Text('操作'),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print(_messageInfo.title);
                    Application.router.navigateTo(context,
                        '/reply?topicId=${_messageInfo.topicId}&topicTitle=${Uri.encodeComponent(_messageInfo.title)}&quote=${Uri.encodeComponent(_messageInfo.content)}');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.reply_outlined, color: Colors.grey, size: 20),
                      Text('回复')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    OperationUtils.postLike(_messageInfo.id.toString())
                        .then((value) {
                      setState(() {
                        _messageInfo.likeState =
                            (_messageInfo.likeState == 0 ? 1 : 0);
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up_outlined,
                          color: _messageInfo.likeState == 1
                              ? Colors.red
                              : Colors.grey,
                          size: 20),
                      Text(_messageInfo.likeCount.toString())
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    OperationUtils.postDislike(_messageInfo.id.toString())
                        .then((value) {
                      setState(() {
                        _messageInfo.likeState =
                            (_messageInfo.likeState == 0 ? 2 : 0);
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.thumb_down_outlined,
                          color: _messageInfo.likeState == 2
                              ? Colors.red
                              : Colors.grey,
                          size: 20),
                      Text(_messageInfo.dislikeCount.toString())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
