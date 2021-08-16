import 'package:flutter/material.dart';

import '../routers/Application.dart';

const List<String> SettingOptionName = [
  '我的资料',
  '我的主题',
  '我的回复',
  '我的好友',
  '我的消息',
  '我的收藏',
  '我的足迹',
  '98实验室',
  '关于我们'
];

List<Icon> SettingOptionIcon = [
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

class SettingOption extends StatelessWidget {
  final int _optionNum;
  SettingOption(this._optionNum);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListTile(
        enabled: true,
        title: Text(SettingOptionName[_optionNum]),
        onTap: () {
          print(_optionNum);
          Application.router.navigateTo(context, '/me?option=$_optionNum');
        },
        leading: SettingOptionIcon[_optionNum],
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
