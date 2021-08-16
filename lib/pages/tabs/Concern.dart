import 'package:flutter/material.dart';

import 'concern_tabs/Board.dart';
import 'concern_tabs/User.dart';
import 'concern_tabs/Update.dart';

import '../../widgets/FloatingButtonCell.dart';

class ConcernPage extends StatefulWidget {
  ConcernPage({Key key}) : super(key: key);

  @override
  _ConcernPageState createState() => _ConcernPageState();
}

class _ConcernPageState extends State<ConcernPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text('我的关注'),
            bottom: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              tabs: <Widget>[
                Tab(
                  text: '关注版面',
                ),
                Tab(
                  text: '关注用户',
                ),
                Tab(
                  text: '收藏更新',
                ),
              ],
            )),
        body: TabBarView(
          children: [
            ConcernBoardPage(),
            ConcernUserPage(),
            ConcernUpdatePage(),
          ],
        ),
        floatingActionButton: FloatingButtonCell(),
      ),
    );
  }
}
