import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Badge(
                  showBadge: true,
                  badgeContent: Text(''),
                  child: Text('回复我的'),
                ),
              ),
              Tab(
                child: Badge(
                  showBadge: true,
                  badgeContent: Text(''),
                  child: Text('@我的'),
                ),
              ),
              Tab(
                child: Badge(
                  showBadge: true,
                  badgeContent: Text(''),
                  child: Text('系统消息'),
                ),
              ),
              Tab(
                child: Badge(
                  showBadge: true,
                  badgeContent: Text(''),
                  child: Text('我的私信'),
                ),
              ),
            ],
          ),
        ),
        body:
            TabBarView(children: [Text('1'), Text('2'), Text('3'), Text('4')]),
      ),
    );
  }
}
