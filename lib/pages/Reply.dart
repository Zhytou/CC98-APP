import 'package:flutter/material.dart';

class ReplyPage extends StatefulWidget {
  final String replyTopicId;
  final String replyTopicTitle;
  final String quote;

  ReplyPage(this.replyTopicId, this.replyTopicTitle, {this.quote});

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  String _replyTopicId;
  String _replyTopicTitle;
  String _quote;

  TextEditingController _titleController;
  TextEditingController _contentController;

  int _currentIndex = 0;

  Map<String, dynamic> reply = {
    "content": "",
    "contentType": 0,
    "title": "",
    "isAnonymous": false
  };

  @override
  void initState() {
    super.initState();
    this._replyTopicId = widget.replyTopicId;
    this._replyTopicTitle = widget.replyTopicTitle;
    this._quote = widget.quote;

    _titleController = TextEditingController();
    _contentController = TextEditingController();

    if (_replyTopicTitle != null && _replyTopicTitle != '') {
      _titleController.text = _replyTopicTitle;
    }
    if (_quote != null && _quote != '') {
      _contentController.text += '[qutoe]';
      _contentController.text += _quote;
      _contentController.text += '[/quote]';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
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
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.only(top: 5, right: 10, left: 10),
          child: Column(
            children: [
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(),
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
                  return Container(
                    height: 150,
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
