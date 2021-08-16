import 'package:flutter/material.dart';
import '../model/Board.dart';

import '../routers/Application.dart';

class SectionBoard extends StatelessWidget {
  final Board _boardInfo;
  SectionBoard(this._boardInfo);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            '/board?id=${_boardInfo.id}&name=${Uri.encodeComponent(_boardInfo.name)}');
      },
      child: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
        ),
        child: Text(_boardInfo.name),
      ),
    );
  }
}
