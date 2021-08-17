import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'Tabs.dart';
import '../util/NetUtils.dart';
import '../routers/Application.dart';

var token;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
// payload登陆这一块建议先去了解一下token机制，最好能用chrome的开发者工具看一下你登陆cc98时传输的东西
// 可以到https://openid.cc98.org/申请你的token
class _LoginPageState extends State<LoginPage> {
  bool _logged = false;
  bool _passwordVisible = true;
  Map<String, dynamic> _payLoad = {
    'client_id': '填写你在https://openid.cc98.org/申请到的id',
    'client_secret': '填写你在https://openid.cc98.org/申请到的secret',
    'grant_type': 'password',
    'username': '',
    'password': '',
    'scope': 'cc98-api',
  };

  TextEditingController _idController;
  TextEditingController _passwordController;

  Dio dio;
  Future<bool> login(payload) async {
    //print(dio.options.contentType);
    try {
      var response =
          await dio.post(Api.Openid + '/connect/token', data: payload);
      //print(response.data);
      token = response.data;
      print(token != null ? token['access_token'] : '');
      //print(response.statusCode);
      return true;
    } catch (e) {
      print(e?.request);
      print(e?.response);
      print(e?.type);
      print(e?.error);
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    dio = Dio(BaseOptions(contentType: 'application/x-www-form-urlencoded'));
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_logged)
      return Tabs();
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('CC98'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'CC98 ID',
                    hintText: 'Username',
                  ),
                  controller: _idController,
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: TextField(
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'CC98密码',
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        //根据passwordVisible状态显示不同的图标
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        //更新状态控制密码显示或隐藏
                        setState(() {
                          this._passwordVisible = !this._passwordVisible;
                        });
                      },
                    ),
                  ),
                  controller: _passwordController,
                ),
              ),
              Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () {
                    _payLoad['username'] = _idController?.text;
                    _payLoad['password'] = _passwordController?.text;
                    print(_payLoad);
                    login(_payLoad).then((value) {
                      setState(() {
                        this._logged = value;
                      });
                      if (_logged == false)
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('登陆失败，请检查密码和网络配置'),
                            );
                          },
                        );
                    });
                  },
                  child: Text(
                    '登  录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      '请示使用内网环境登录',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    Text('CC98唯一官方网址：www.cc98.org',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        )),
                  ],
                ),
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/WelcomePic.jpeg'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  '欢迎前辈回家~',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Application.router.navigateTo(context, '/help');
                  },
                  child: Text(
                    '帮助与说明',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
