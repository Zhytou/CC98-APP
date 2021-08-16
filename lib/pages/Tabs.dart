import 'package:flutter/material.dart';

import 'tabs/Home.dart';
import 'tabs/New.dart';
import 'tabs/Concern.dart';
import 'tabs/Section.dart';
import 'tabs/Settings.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Widget> _pages = [
    HomePage(),
    NewPage(),
    ConcernPage(),
    SectionPage(),
    SettingPage(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._pages[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        currentIndex: this._currentIndex,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '热门'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "新帖"),
          BottomNavigationBarItem(icon: Icon(Icons.add_location), label: "关注"),
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "版面"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "我"),
        ],
      ),
    );
  }
}
