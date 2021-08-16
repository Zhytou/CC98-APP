import 'package:flutter/material.dart';

import '../../model/Index.dart';
import '../../model/Board.dart';
import '../../routers/Application.dart';
import '../../util/DataUtils.dart';
import '../../widgets/IndexCell.dart';

class BoardPage extends StatefulWidget {
  final String _boardId;
  final String _boardName;
  BoardPage(this._boardId, this._boardName);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  bool _flag = true;
  String _boardId;
  String _boardName;

  int _currentIndex = 0;
  Map<String, dynamic> _params = {'from': 0, 'size': 20};

  List<Index> _indexes = [];
  Board _board;

  getData() {
    DataUtils.getBoard(_boardId).then((result) {
      setState(() {
        _board = result;
      });
    });
  }

  getLsitData() {
    DataUtils.getBoardTopicList(_boardId, _params).then((resultList) {
      setState(() {
        _indexes = resultList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _boardId = widget._boardId;
    _boardName = widget._boardName;
    getData();
    getLsitData();
  }

  List<Widget> getMasterList(BuildContext context) {
    List<Widget> _resultList = [
      Text(
        '版主：',
        style: TextStyle(color: Colors.pink[400], fontSize: 13),
      )
    ];
    for (int i = 0;
        i <
            (_board == null || _board.boardMasters == null
                ? 0
                : _board.boardMasters.length);
        i++) {
      String master = _board.boardMasters[i];
      _resultList.add(
        Container(
          child: TextButton(
            onPressed: () {
              Application.router.navigateTo(
                  context, '/user?id=-1&name=${Uri.encodeComponent(master)}');
            },
            child: Text(
              master,
              style: TextStyle(color: Colors.lightBlue[300], fontSize: 13),
            ),
          ),
        ),
      );
    }
    return _resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, num) {
            if (num == 0)
              return Container(
                padding: EdgeInsets.only(right: 10, left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.cc98.org/static/images/_' +
                                      Uri.encodeComponent(
                                          _board == null || _board.name == null
                                              ? _boardName
                                              : _board?.name) +
                                      '.png'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _boardName,
                                  style: TextStyle(
                                    color: Colors.pink[400],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _flag = !_flag;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment(0, 0),
                                    height: 25,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: _flag
                                          ? Border()
                                          : Border.all(width: 0.5),
                                      color: _flag ? Colors.red : Colors.white,
                                    ),
                                    child: Text(
                                      _flag ? '+关注' : '已关注',
                                      style: TextStyle(
                                          color: _flag
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment(-1, 0),
                              child: Text(
                                '今日贴数：' +
                                    (_board == null || _board.todayCount == null
                                        ? '0'
                                        : _board.todayCount.toString()) +
                                    '    ' +
                                    '总主题数：' +
                                    (_board == null || _board.topicCount == null
                                        ? '0'
                                        : _board.topicCount.toString()),
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(children: [
                      Text(
                        '版面介绍：',
                        style: TextStyle(color: Colors.pink[400], fontSize: 13),
                      ),
                      Text(
                        _board == null || _board.description == null
                            ? ''
                            : _board.description,
                        style: TextStyle(fontSize: 13),
                      )
                    ]),
                    Row(
                      children: getMasterList(context),
                    ),
                  ],
                ),
              );
            else
              return IndexCell(
                this._indexes[num - 1].topic,
                this._indexes[num - 1].user,
                this._indexes[num - 1].board,
              );
          },
          separatorBuilder: (context, int) {
            return Divider(thickness: 2);
          },
          itemCount: (_indexes == null ? 0 : _indexes.length) + 1),
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
            Application.router.navigateTo(context, 'search');
          }

          if (index == 1) {
            _params['from'] -= _params['size'] + 1;
            if (_params['from'] < 0) _params['from'] = 0;
            getLsitData();
          }

          if (index == 3) {
            _params['from'] += _params['size'] + 1;
            getLsitData();
          }

          if (index == 4) {
            Application.router.navigateTo(context, '/write');
          }

          if (index != 2) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '搜索',
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
            icon: Icon(Icons.create),
            label: '发帖',
          ),
        ],
      ),
    );
  }
}
