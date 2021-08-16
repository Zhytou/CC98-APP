import 'package:flutter/material.dart';

import '../../model/Index.dart';
import '../../model/User.dart';
import '../../util/DataUtils.dart';
import '../../widgets/UserAttribute.dart';
import '../../widgets/UserHead.dart';
import '../../widgets/UserTopicCell.dart';

String getLastLogOnTime(String time) {
  List<String> times = time.split('T');
  String result = '';
  for (int i = 0; i < times?.length; i++) {
    result += times[i];
    result += ' ';
  }
  return result;
}

class UserPage extends StatefulWidget {
  final String userId;
  final String userName;
  UserPage(
    this.userId, {
    this.userName,
  });

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String _userId;
  String _userName;

  int _currentIndex = 0;
  Map<String, dynamic> _params = {'from': 0, 'size': 10, 'userId': 0};

  User _user;
  List<Topic> _topics = [];

  getData() {
    if (_userName != null) {
      DataUtils.getUserByName(_userName).then((result) {
        setState(() {
          _user = result;
          _params['userId'] = _user.id;
          DataUtils.getUserTopicList(_user.id.toString(), _params)
              .then((resultList) {
            setState(() {
              _topics = resultList;
            });
          });
        });
      });
    } else {
      DataUtils.getUser(_userId).then((result) {
        setState(() {
          _user = result;
        });
      });

      DataUtils.getUserTopicList(_userId, _params).then((resultList) {
        setState(() {
          _topics = resultList;
        });
      });
    }
  }

  getListData() {
    DataUtils.getUserTopicList(_user.id.toString(), _params).then((resultList) {
      setState(() {
        _topics = resultList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    _userName = widget.userName;
    _params['userId'] =
        _userId != null && _userId != '-1' ? int.parse(_userId) : -1;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, num) {
            if (num == 0)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserHead(_user),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineButton(
                        onPressed: () {},
                        borderSide: BorderSide(
                            color: _user == null || !_user.isFollowing
                                ? Colors.red
                                : Colors.black),
                        child: Text(
                          _user == null || !_user.isFollowing ? '+关注' : '已关注',
                          style: TextStyle(
                              color: _user == null || !_user.isFollowing
                                  ? Colors.red
                                  : Colors.black),
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {},
                        borderSide: BorderSide(color: Colors.red),
                        child: Text('私信', style: TextStyle(color: Colors.red)),
                      )
                    ],
                  )
                ],
              );
            else if (num == 1)
              return UserAttribute(_user);
            else if (num == 2)
              return Container(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '个性签名',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(_user == null || _user.signatureCode == null
                              ? ''
                              : _user.signatureCode)
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '最后登录',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(_user == null || _user.lastLogOnTime == null
                              ? ''
                              : getLastLogOnTime(_user.lastLogOnTime))
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        '发表的主题:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            else
              return UserTopicCell(_topics[num - 3]);
          },
          separatorBuilder: (context, num) {
            return Divider(thickness: 2);
          },
          itemCount: (_topics == null ? 0 : _topics?.length) + 3),
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
          if (index == 0) {
            _params['from'] -= _params['size'] + 1;
            if (_params['from'] < 0) {
              _params['from'] = 0;
            }
            getListData();
          }

          if (index == 2) {
            _params['from'] += _params['size'] + 1;
            getListData();
          }

          if (index != 1) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
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
        ],
      ),
    );
  }
}
