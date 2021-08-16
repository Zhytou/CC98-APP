import 'package:flutter/material.dart';

import '../routers/Application.dart';

class FloatingButtonCell extends StatelessWidget {
  const FloatingButtonCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Opacity(
                opacity: 0.7,
                child: FloatingActionButton(
                  heroTag: 'search',
                  onPressed: () {
                    Application.router.navigateTo(context, '/search');
                  },
                  child: Icon(Icons.search, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Opacity(
                opacity: 0.7,
                child: FloatingActionButton(
                  heroTag: 'write',
                  onPressed: () {
                    Application.router.navigateTo(context, '/write');
                  },
                  child: Icon(Icons.edit, color: Colors.white),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
