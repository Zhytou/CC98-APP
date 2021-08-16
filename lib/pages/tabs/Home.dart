import 'package:flutter/material.dart';

import 'home_tabs/Day.dart';
import 'home_tabs/Week.dart';
import 'home_tabs/Month.dart';
import 'home_tabs/Year.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('热门话题'),
          bottom: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorWeight: 5,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              tabs: <Widget>[
                Tab(
                  text: '今日',
                ),
                Tab(
                  text: '本周',
                ),
                Tab(
                  text: '本月',
                ),
                Tab(
                  text: '往年今日',
                ),
              ]),
        ),
        body: TabBarView(children: <Widget>[
          DayPage(),
          WeekPage(),
          MonthPage(),
          YearPage(),
        ]),
      ),
    );
  }
}
