import 'package:flutter/material.dart';
import 'package:myapp/widgets/UserTopicCell.dart';

import '../../../model/Index.dart';
import '../../../util/DataUtils.dart';
import '../../../widgets/UserHead.dart';
import '../../../widgets/LoadMoreCell.dart';

class MyCollectionsPage extends StatefulWidget {
  @override
  _MyCollectionsPageState createState() => _MyCollectionsPageState();
}

class _MyCollectionsPageState extends State<MyCollectionsPage> {
  List<Topic> _topics = [];
  Map<String, dynamic> _params;
  int _currentIndex = 0;

  getData() {
    DataUtils.getMyCollections(_params).then((resultList) {
      setState(() {
        _topics = resultList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _params = {'from': 0, 'size': 10};
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
        itemCount: _topics == null ? 1 : _topics.length,
        itemBuilder: (context, num) {
          if (_topics.isNotEmpty)
            return UserTopicCell(_topics[num]);
          else
            return LoadMoreCell();
        },
        separatorBuilder: (context, num) {
          return Divider(thickness: 2);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme: IconThemeData(size: 20),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 0) {
            _params['from'] = 0;
            getData();
          }
          if (index == 1) {
            _params['from'] -= _params['size'] + 1;
            if (_params['from'] < 0) _params['from'] = 0;
            getData();
          }

          if (index == 3) {
            _params['from'] += _params['size'] + 1;
            getData();
          }

          if (index != 2) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.first_page_outlined),
            label: '首页',
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
            icon: Icon(Icons.last_page_outlined),
            label: '末页',
          ),
        ],
      ),
    );
  }
}
