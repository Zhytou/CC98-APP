import 'package:flutter/material.dart';
import 'package:myapp/model/User.dart';

class UserAttribute extends StatelessWidget {
  final User _userInfo;
  UserAttribute(this._userInfo);

  renderSingeAttr(String attrName, String attrValue) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(attrValue == null ? '0' : attrValue,
              style: TextStyle(fontSize: 15)),
          Text(attrName, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      alignment: Alignment(0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          renderSingeAttr('总贴数', _userInfo?.postCount.toString()),
          renderSingeAttr('风评', _userInfo?.popularity.toString()),
          renderSingeAttr('威望', _userInfo?.prestige.toString()),
          renderSingeAttr('财富值', _userInfo?.wealth.toString()),
          renderSingeAttr('收到的赞', _userInfo?.popularity.toString()),
        ],
      ),
    );
  }
}
