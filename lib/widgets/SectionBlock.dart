import 'package:flutter/material.dart';

import '../routers/Application.dart';
import '../model/Board.dart';
import 'SectionBoard.dart';

class SectionBlock extends StatelessWidget {
  final Block _blockInfo;
  SectionBlock(this._blockInfo);

  List<Widget> getMasterList(BuildContext context) {
    List<Widget> _resultList = [
      Text(
        _blockInfo.name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      )
    ];
    for (int i = 0; i < _blockInfo.masters.length; i++) {
      String master = _blockInfo.masters[i];
      _resultList.add(
        Container(
          child: TextButton(
            onPressed: () {
              Application.router.navigateTo(
                  context, '/user?name=${Uri.encodeComponent(master)}');
            },
            child: Text(
              master,
              style: TextStyle(color: Colors.lightBlue[300], fontSize: 15),
            ),
          ),
        ),
      );
    }
    return _resultList;
  }

  List<SectionBoard> getBoardList() {
    List<SectionBoard> _resultList = [];
    for (int i = 0; i < _blockInfo.boards.length; i++) {
      var _boardInfo = Board.fromJson(_blockInfo.boards[i]);
      var _boardCell = SectionBoard(_boardInfo);
      _resultList.add(_boardCell);
    }
    return _resultList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: getMasterList(context),
            ),
            Wrap(
              children: getBoardList(),
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
            )
          ],
        ));
  }
}
