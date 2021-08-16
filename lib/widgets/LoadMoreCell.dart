import 'package:flutter/material.dart';

class LoadMoreCell extends StatelessWidget {
  const LoadMoreCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Center(
        child: Opacity(
          opacity: 1.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
