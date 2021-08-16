import 'package:flutter/material.dart';
//import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutUsPage extends StatelessWidget {
  final String data = '''
<h1 align = "center">CC98</h1>\n

<h3>简介</h3>\n

<backquote>官网：https://www.cc98.org </backquote>\n

浙江大学CC98论坛，简称“CC98论坛”或“98”，是一个能够联结学生、老师、学校的交流平台，也为以浙大师生为主体的广大网友提供一个网上学习和交流的途径，从中充分展现当代大学生多姿多彩的课余生活和网上文化生活。\n

<h3>我们的平台</h3>\n

微信：浙江大学CC98论坛 或 zjucc98\n

微博：浙江大学CC98论坛\n

Bilibili：浙江大学CC98论坛\n

<h3>开发者</h3>

ZhY
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Html(
          data: data,
        ),
      ),
    );
  }
}
