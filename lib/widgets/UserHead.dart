import 'package:flutter/material.dart';

import '../model/User.dart';

String getRegisterTime(time) {
  if (time == null) return '';
  List<String> times = time.split('T');
  return times[0];
}

class UserHead extends StatelessWidget {
  final User _user;
  UserHead(this._user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(_user == null || _user?.portraitUrl == null
                    ? 'https://www.cc98.org/static/images/default_avatar_boy.png'
                    : _user?.portraitUrl),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _user == null || _user?.name == null ? '' : _user?.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                        child: Image.asset(_user == null || _user.gender == 1
                            ? 'assets/images/male.jpg'
                            : 'assets/images/female.jpg'),
                      ),
                      Container(
                        height: 18,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Text(
                          '粉丝 ' +
                              (_user == null || _user.fanCount == null
                                  ? '0'
                                  : _user.fanCount.toString()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Text(
                    'Lv.' +
                        (_user == null || _user.levelTitle == null
                            ? 'baby'
                            : _user.levelTitle) +
                        ' 注册时间' +
                        getRegisterTime(_user?.registerTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
