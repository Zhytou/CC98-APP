import 'package:flutter/material.dart';

import '../../../model/User.dart';
import '../../../util/DataUtils.dart';
import '../../../widgets/UserHead.dart';
import '../../../widgets/LoadMoreCell.dart';

class MyFriendsPage extends StatefulWidget {
  @override
  _MyFriendsPageState createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriendsPage> {
  List<User> _fans = [];
  List<User> _idols = [];

  bool _fanFlag = false,
      _idolFlag = false; //flag为真，表示用户的粉丝或关注数量为零，而非_fans或_idols异步仍未加载完
  Map<String, dynamic> _fanParams, _idolParams;
  ScrollController _fanController, _idolController;

  getData() {
    DataUtils.getMyFans(_fanParams).then((resultList) {
      setState(() {
        _fans.addAll(resultList);
        if (_fans.isEmpty) _fanFlag = true;
      });
    });
    DataUtils.getMyIdols(_idolParams).then((resultList) {
      setState(() {
        _idols.addAll(resultList);
        if (_idols.isEmpty) _idolFlag = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _idolParams = {'from': 0, 'size': 10};
    _idolParams = {'from': 0, 'size': 10};

    _fanController = ScrollController();
    _idolController = ScrollController();

    _fanController.addListener(() {
      if (_fanController.position.pixels ==
          _fanController.position.maxScrollExtent) {
        _fanParams['from'] += _fanParams['size'] + 1;
        getData();
      }
    });

    _idolController.addListener(() {
      if (_idolController.position.pixels ==
          _idolController.position.maxScrollExtent) {
        _idolParams['from'] += _idolParams['size'] + 1;
        getData();
      }
    });

    getData();
  }

  @override
  void dispose() {
    _fanController.dispose();
    _idolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              indicatorWeight: 2,
              tabs: [
                Tab(
                  child: Text('我的粉丝'),
                ),
                Tab(
                  child: Text('我的关注'),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.separated(
                controller: _fanController,
                itemCount: _fans == null ? 0 : _fans.length + 1,
                itemBuilder: (context, num) {
                  //_fans 可能还没加载完
                  if (!_fanFlag) {
                    if (_fans.isNotEmpty && num < _fans.length)
                      return UserHead(_fans[num]);
                    else if (_fans.isEmpty ||
                        num > _fanParams['from'] + _fanParams['size'])
                      return LoadMoreCell();
                    else
                      return Container();
                  } else
                    return Container();
                },
                separatorBuilder: (context, num) {
                  return Divider(thickness: 2);
                },
              ),
              ListView.separated(
                controller: _idolController,
                itemCount: _idols == null ? 0 : _idols.length + 1,
                itemBuilder: (context, num) {
                  if (!_idolFlag) {
                    if (_idols.isNotEmpty && num < _idols.length)
                      return UserHead(_idols[num]);
                    else if (_idols.isEmpty ||
                        num > _idolParams['from'] + _idolParams['size'])
                      return LoadMoreCell();
                    else
                      return Container();
                  } else
                    return Container();
                },
                separatorBuilder: (context, num) {
                  return Divider(thickness: 2);
                },
              )
            ],
          ),
        ));
  }
}
