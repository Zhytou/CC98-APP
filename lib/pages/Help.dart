import 'package:flutter/material.dart';

const List<String> HelpOptionName = [
  '常见问题',
  '注册账号',
  '忘记密码',
  'RVPN攻略',
  '登陆失败怎么办',
  '闪屏怎么办',
  '关于我们',
  '意见反馈',
];

class HelpPage extends StatelessWidget {
  const HelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, num) {
            return Container(
              height: 40,
              child: ListTile(
                enabled: true,
                title: Text(HelpOptionName[num]),
                onTap: () {},
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            );
          },
          separatorBuilder: (context, num) {
            return Divider(thickness: 2);
          },
          itemCount: 8),
    );
  }
}
