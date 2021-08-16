import 'package:flutter/material.dart';

import '../../model/User.dart';
import '../../util/DataUtils.dart';
import '../../routers/Application.dart';
import '../../widgets/UserAttribute.dart';
import '../../widgets/UserHead.dart';
import '../../widgets/LoadMoreCell.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  User _user;
  getData() {
    DataUtils.getMe().then((result) {
      setState(() {
        _user = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<String> settingOptionName = [
    '我的资料',
    '我的主题',
    '我的回复',
    '我的好友',
    '我的消息',
    '我的收藏',
    '98实验室',
    '关于我们'
  ];

  List<Icon> settingOptionIcon = [
    Icon(
      Icons.person,
      color: Colors.blue[800],
    ),
    Icon(
      Icons.psychology_outlined,
      color: Colors.green,
    ),
    Icon(
      Icons.keyboard,
      color: Colors.lightBlueAccent,
    ),
    Icon(
      Icons.people_outline_outlined,
      color: Colors.pink,
    ),
    Icon(
      Icons.alarm,
      color: Colors.redAccent[100],
    ),
    Icon(
      Icons.star,
      color: Colors.blueAccent,
    ),
    Icon(
      Icons.lightbulb,
      color: Colors.yellow[600],
    ),
    Icon(
      Icons.info_outline,
      color: Colors.purpleAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: ListView.separated(
          itemBuilder: (context, num) {
            if (num == 0) {
              if (_user == null)
                return LoadMoreCell();
              else
                return UserHead(_user);
            } else if (num == 1)
              return UserAttribute(_user);
            else
              return Container(
                height: 50,
                child: ListTile(
                  enabled: true,
                  title: Text(settingOptionName[num - 2]),
                  onTap: () {
                    int option = num - 2;
                    Application.router
                        .navigateTo(context, '/me?option=$option');
                  },
                  leading: settingOptionIcon[num - 2],
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              );
          },
          separatorBuilder: (context, num) {
            return Divider(thickness: 1);
          },
          itemCount: _user == null ? 1 : 10),
    );
  }
}
