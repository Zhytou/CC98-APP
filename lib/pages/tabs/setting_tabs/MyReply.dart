import 'package:flutter/material.dart';

import '../../../model/Post.dart';
import '../../../util/DataUtils.dart';
import '../../../widgets/UserReplyCell.dart';

class MyReplyPage extends StatefulWidget {
  @override
  _MyReplyPageState createState() => _MyReplyPageState();
}

class _MyReplyPageState extends State<MyReplyPage> {
  List<Message> _messages = [];
  Map<String, dynamic> _params;

  int _currentIndex;

  Future getData() async {
    DataUtils.getMyReplyList(_params).then((resultList) {
      setState(() {
        if (resultList.isEmpty) {
          _params['from'] -= _params['size'] + 1;
          if (_params['from'] < 0) {
            _params['from'] = 0;
          }
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('已经是最后一页'),
              );
            },
          );
        } else {
          _messages = resultList;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _params = {'from': 0, 'size': 10};
    _currentIndex = 0;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, num) {
            return UserReplyCell(_messages[num]);
          },
          separatorBuilder: (context, num) {
            return Divider(thickness: 2);
          },
          itemCount: _messages?.length),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 0) {
            _params['from'] = 0;
            getData();
          }
          if (index == 1) {
            _params['from'] -= _params['size'] + 1;
            if (_params['from'] < 0) _params['from'] = 0;
            getData();
          }

          if (index == 3) {
            _params['from'] += _params['size'] + 1;
            getData();
          }

          if (index != 2) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
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
                ((_params['from'] / _params['size']).floor() + 1).toString()),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_rounded),
            label: '下一页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.last_page_outlined),
            label: '末页',
          ),
        ],
      ),
    );
  }
}
