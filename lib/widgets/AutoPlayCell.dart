import 'package:flutter/material.dart';
import '../model/Index.dart';
import 'RecommendationCell.dart';

class AutoPlayCell extends StatelessWidget {
  final List<Topic> _recommendations;
  AutoPlayCell(this._recommendations);

  renderRecommendation(context, num) {
    if (num < _recommendations.length)
      return RecommendationCell(_recommendations[num]);
  }

  @override
  Widget build(BuildContext context) {
    var _controller = PageController();

    return Container(
      height: 160,
      padding: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '推荐阅读',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 120,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount:
                      _recommendations == null ? 0 : _recommendations?.length,
                  itemBuilder: (context, num) =>
                      renderRecommendation(context, num),
                ),
                //formTip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
