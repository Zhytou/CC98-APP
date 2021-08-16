import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Text('基本信息',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('用户iD:'),
              Text('性别:'),
              Text('注册时间:'),
              Text('qq:'),
              Text('上次登录:'),
              Text('我的数据',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('发帖数:'),
              Text('风评:'),
              Text('财富值:'),
              Text('关注数:'),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('修改资料'),
                ),
              )
            ],
          ),
        ));
  }
}
