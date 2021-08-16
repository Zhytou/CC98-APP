import 'package:flutter/material.dart';

import '../../model/Board.dart';
import '../../util/DataUtils.dart';
import '../../widgets/SectionBlock.dart';
import '../../widgets/LoadMoreCell.dart';

class SectionPage extends StatefulWidget {
  SectionPage({Key key}) : super(key: key);

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  List<Block> _blocks = [];

  void getData() {
    DataUtils.getSectionList().then((resultList) {
      setState(() {
        _blocks = resultList;
      });
    });
  }

  renderBlock(context, int num) {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('版面列表'),
      ),
      body: ListView.builder(
          itemCount: _blocks.isEmpty ? 1 : _blocks.length,
          itemBuilder: (context, num) {
            if (_blocks.isNotEmpty && num < _blocks.length)
              return SectionBlock(_blocks[num]);
            else
              return LoadMoreCell();
          }),
    );
  }
}
