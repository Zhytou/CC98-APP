import 'package:flutter/material.dart';
import '../model/Index.dart';
import '../routers/Application.dart';

class RecommendationCell extends StatelessWidget {
  final Topic _topic;
  RecommendationCell(this._topic);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context,
            '/topic?id=${_topic.id}&title=${Uri.encodeComponent(_topic?.title)}');
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
          /*image: DecorationImage(
            image: NetworkImage(' '),
            fit: BoxFit.scaleDown,
          ),*/
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    image: DecorationImage(
                      image: NetworkImage(
                          _topic == null || _topic?.imageUrl == null
                              ? ' '
                              : _topic?.imageUrl),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _topic == null || _topic?.title == null
                        ? ' '
                        : _topic?.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Expanded(
              child: Text(
                _topic == null || _topic?.content == null
                    ? ' '
                    : _topic?.content,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
