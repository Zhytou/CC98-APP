import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class WritePage extends StatefulWidget {
  WritePage({Key key}) : super(key: key);

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _pickerData = '';
  String _pickedBoardName = '未选择 未选择';

  TextEditingController _titleController;
  TextEditingController _contentController;
  int _currentIndex;

  Map<String, dynamic> reply = {
    "content": "",
    "contentType": 0,
    "title": "",
    "isAnonymous": false
  };

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    getPickerData().then((value) {
      setState(() {
        _pickerData = value;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<String> getPickerData() async {
    return await rootBundle.loadString('assets/PickerData.json');
  }

  showPicker(BuildContext context) {
    //print(_pickerData);
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: JsonDecoder().convert(_pickerData)),
        cancelText: '取消',
        cancelTextStyle: TextStyle(color: Colors.blue),
        confirmText: '确认',
        confirmTextStyle: TextStyle(color: Colors.blue),
        changeToFirst: false,
        textAlign: TextAlign.left,
        selectedTextStyle: TextStyle(color: Colors.black),
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _pickedBoardName = '';
            for (int i = 0; i < picker.getSelectedValues().length; i++) {
              _pickedBoardName = picker.getSelectedValues()[i] + ' ';
            }
          });
        });
    picker.show(_scaffoldKey.currentState);
  }

  List<Widget> getAcPic() {
    List<Widget> resultList = [];
    for (var i = 1; i < 10; i++) {
      resultList.add(InkWell(
          onTap: () {
            setState(() {
              _contentController.text += '[ac0$i]';
            });
          },
          child: Image.asset(
            'assets/images/ac/0$i.png',
            height: 50,
          )));
    }
    for (var i = 10; i < 51; i++) {
      resultList.add(InkWell(
          onTap: () {
            setState(() {
              _contentController.text += '[ac$i]';
            });
          },
          child: Image.asset(
            'assets/images/ac/$i.png',
            height: 50,
          )));
    }
    for (var i = 2000; i < 2056; i++) {
      resultList.add(InkWell(
          onTap: () {
            setState(() {
              _contentController.text += '[ac$i]';
            });
          },
          child: Image.asset(
            'assets/images/ac/$i.png',
            height: 50,
          )));
    }
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.only(top: 5, right: 10, left: 10),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment(-1, 0),
                child: InkWell(
                  onTap: () {
                    showPicker(context);
                  },
                  child: Text('选择版面: ' + _pickedBoardName,
                      style: TextStyle(fontSize: 18)),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(),
                  hintText: '标题',
                ),
                controller: _titleController,
              ),
              SizedBox(
                height: 40,
                child: TabBar(
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    tabs: [
                      Icon(Icons.photo_outlined),
                      Icon(Icons.video_library_outlined),
                      Image.asset('assets/images/ac/01.png'),
                    ]),
              ),
              Builder(builder: (context) {
                if (_currentIndex == 2) {
                  return SizedBox(
                    height: 80,
                    child: SingleChildScrollView(
                      child: Wrap(children: getAcPic()),
                    ),
                  );
                } else
                  return Container();
              }),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(),
                  hintText: '诸位在校，有两个问题应该自己问问 第一，到浙大来做什么 第二，将来毕业后做什么样的人',
                  hintMaxLines: 4,
                ),
                maxLines: 10,
                controller: _contentController,
              ),
              Container(
                alignment: Alignment(0, 0),
                height: 40,
                width: 200,
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '发  表',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
