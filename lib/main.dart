import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'routers/Application.dart';
import 'pages/Login.dart';
import 'routers/Routes.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.blue[100],
      ),
      title: 'CC98',
      onGenerateRoute: Application.router.generator,
      home: LoginPage(),
    );
  }
}
