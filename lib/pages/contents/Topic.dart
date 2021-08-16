import 'package:flutter/material.dart';

import '../../model/Index.dart';
import '../../model/Post.dart';
import '../../routers/Application.dart';
import '../../util/DataUtils.dart';
import '../../widgets/PostCell.dart';

class TopicPage extends StatefulWidget {
  final String _topicId;
  final String _topicTitle;
  TopicPage(this._topicId, this._topicTitle);
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  String _topicId;
  String _topicTitle;

  int _currentIndex = 0;
  Map<String, dynamic> _params = {'from': 0, 'size': 10};

  Topic _topic;
  List<Post> _posts = [];

  getData() {
    DataUtils.getTopic(_topicId).then((result) {
      setState(() {
        _topic = result;
      });
    });
    DataUtils.getPostList(_topicId, _params).then((resultList) {
      setState(() {
        _posts = resultList;
        for (var i = 0; i < _posts.length; i++) {
          _posts[i].message.title = _topicTitle;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _topicId = widget._topicId;
    _topicTitle = widget._topicTitle;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          padding: EdgeInsets.only(top: 5),
          itemBuilder: (conetxt, num) {
            if (num == 0)
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _topicTitle == null ? '' : '  ' + _topicTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    //把楼主的发言和标题放在一起
                    PostCell(_posts[num].message, _posts[num].user)
                  ],
                ),
              );
            else {
              return PostCell(_posts[num].message, _posts[num].user);
            }
          },
          separatorBuilder: (conetxt, num) {
            return Divider(thickness: 2);
          },
          itemCount: (_posts == null ? 0 : _posts?.length)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            _params['from'] = 0;
            getData();
          }

          if (index == 2) {
            _params['from'] -= _params['size'] + 1;
            if (_params['from'] < 0) _params['from'] = 0;
            getData();
          }

          if (index == 4) {
            if (_topic != null &&
                _params['from'] + _params['size'] + 1 <= _topic.replyCount)
              _params['from'] += _params['size'] + 1;
            getData();
          }

          if (index == 5) {
            Application.router.navigateTo(context,
                '/reply?topicId=${Uri.encodeComponent(_topicId)}&topicTitle=${Uri.encodeComponent(_topicTitle)}');
          }
          if (index != 3) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: '操作',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.first_page_outlined),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_rounded),
            label: '上一页',
          ),
          BottomNavigationBarItem(
            icon: Text(
                ((_params['from'] / _params['size']).floor() + 1).toString() +
                    '/' +
                    (_topic == null ? 1 : (_topic.replyCount / 10).floor())
                        .toString()),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_rounded),
            label: '下一页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reply),
            label: '回复',
          ),
        ],
      ),
    );
  }
}
