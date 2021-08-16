class ConvertUtils {
  static List<RegExp> tags = [
    RegExp("\\[img\\](.*?)\\[\/img\\]", dotAll: true), // 图片
    RegExp("\\[video\\](.*?)\\[\/video\\]", dotAll: true), // 视频
    RegExp("\\[url=(.*?)\\](.*?)\\[\/url\\]", dotAll: true), // 链接
    RegExp("\\[quote\\](.*?)\\[\/quote\\]", dotAll: true), // 引用
    RegExp("\\[table\\](.*?)\\[\/table\\]", dotAll: true), // 表格
    RegExp("\\[th\\](.*?)\\[\/th\\]", dotAll: true), // 表头
    RegExp("\\[tr\\](.*?)\\[\/tr\\]", dotAll: true), // 表格行
    RegExp("\\[td\\](.*?)\\[\/td\\]", dotAll: true), // 表格列

    //font
    RegExp("\\[size=([1-7])\\](.*?)\\[\/size\\]", dotAll: true), // 字体大小
    RegExp("\\[color=(.*?)\\](.*?)\\[\/color\\]", dotAll: true), // 颜色
    RegExp("\\[align=(.*?)\\](.*?)\\[\/align\\]", dotAll: true), // 对齐格式
    RegExp("\\[b\\](.*?)\\[\/b\\]", dotAll: true), // 黑体加粗
    RegExp("\\[i\\](.*?)\\[\/i\\]", dotAll: true), // 斜体
    RegExp("\\[u\\](.*?)\\[\/u\\]", dotAll: true), // 下划线
    RegExp("\\[del\\](.*?)\\[\/del\\]", dotAll: true), // 删除线

    //emoji
    RegExp("\\[cc98([0-9][0-9]*)\\]"), //CC98
    RegExp("\\[ac([0-9][0-9]*)\\]"), //AC娘
    RegExp("\\[a:([0-9][0-9]*)\\]"), //麻将脸 a
    RegExp("\\[f:([0-9][0-9]*)\\]"), //麻将脸 f
    RegExp("\\[tb([0-9][0-9]*)\\]"), //贴吧
    RegExp("\\[ms([0-9][0-9]*)\\]"), //雀魂
    RegExp("\\[em([0-9][0-9]*)\\]") //经典
  ];

  static String bbcode2Html(String s) {
    List<String> precedingTagsTarget = [
      '<img src = "', //图片
      '<video width = "200px" height = "500px"> <source src = "', // 视频
      '<a href= "', // 链接
      '<details>', // 引用
      '<table border = "1">', //表格
      '<th>', // 表头
      '<tr>', // 行
      '<td>', // 列

      //font
      '<font size = "', //字体大小
      '<font color = "', //字体颜色
      '<div align = "', //对齐格式
      '<b>', //字体加粗
      '<i>', //斜体
      '<u>', //下划线
      '<del>', //删除线

      //emoji
      '<img src = "https://www.cc98.org/static/images/CC98/CC98',
      '<img src = "https://www.cc98.org/static/images/ac/',
      '<img src = "https://www.cc98.org/static/images/mahjong/animal2017/',
      '<img src = "https://www.cc98.org/static/images/mahjong/face2017/',
      '<img src = "https://www.cc98.org/static/images/tb/tb',
      '<img src = "https://www.cc98.org/static/images/ms/ms',
      '<img src = "https://www.cc98.org/static/images/em/em',
    ];
    List<String> followingTagsTarget = [
      '">', //图片
      '"> </video>', //视频
      '">查看原帖</a>', //链接
      '</details>', //引用
      '</table>', //表格
      '</th>', // 表头
      '</tr>', // 行
      '</td>', // 列

      // font
      '">', // 字体大小
      '">', // 颜色
      '">', // 对齐
      '</b>', // 加粗
      '</i>', // 斜体
      '</u>', // 下划线
      '</del>', // 删除线

      // emoji
      '.gif" height = "40px">',
      '.png" height = "40px">',
      '.png" height = "40px">',
      '.gif" height = "40px">',
      '.png" height = "40px">',
      '.png" height = "40px">',
      '.gif" height = "40px">',
    ];

    String res = s;
    for (var i = 0; i < tags.length; i++) {
      //匹配两次保障嵌套匹配
      for (int j = 0; j < 2; j++) {
        res = res.replaceAllMapped(tags[i], (match) {
          if (i == 4 || i == 5)
            return precedingTagsTarget[i] +
                match[1] +
                followingTagsTarget[i] +
                match[2] +
                '</font>';
          else if (i == 6)
            return precedingTagsTarget[i] +
                match[1] +
                followingTagsTarget[i] +
                match[2] +
                '</div>';
          else
            return precedingTagsTarget[i] + match[1] + followingTagsTarget[i];
        });
      }
    }

    return res;
  }

  static String bbcode2Markdown(String s) {
    List<String> precedingTagsTarget = [
      // other
      '![img](', // 图片
      '', // 视频
      '[](', // 链接
      '>', // 引用
      '', // 表格
      '', // 表头
      '', // 行
      '', // 列

      // font
      '', // 字体大小
      '', // 字体颜色
      '', // 对齐格式
      '**', // 加粗
      '*', //斜体
      '<u>', // 下划线
      '~~', // 删除线

      // emoji
      '![cc98](https://www.cc98.org/static/images/CC98/CC98',
      '![ac](https://www.cc98.org/static/images/ac/',
      '![mj](https://www.cc98.org/static/images/mahjong/animal2017/',
      '![mj](https://www.cc98.org/static/images/mahjong/face2017/',
      '![tb](https://www.cc98.org/static/images/tb/tb',
      '![ms](https://www.cc98.org/static/images/ms/ms',
      '![em](https://www.cc98.org/static/images/em/em',
    ];
    List<String> followingTagsTarget = [
      ')', // 图片
      '', // 视频
      ')', // 链接
      '', // 引用
      '', //
      '', // 表格
      '', // 表头
      '', // 行
      '', // 列

      // font
      '', // 字体大小
      '', // 字体颜色
      '', // 对齐格式
      '**', // 加粗
      '*', // 斜体
      '</u>', // 下划线
      '~~', // 删除线

      // emoji
      '.gif)', // CC98
      '.png)', // ac娘
      '.png)', // 麻将脸
      '.gif)', // 麻将脸
      '.png)', // 贴吧
      '.png)', // 雀魂
      '.gif)', // 经典
    ];

    String res = s;

    for (var i = 0; i < tags.length; i++) {
      for (var j = 0; j < 2; j++) {
        res = res.replaceAllMapped(tags[i], (match) {
          return precedingTagsTarget[i] + match[1] + followingTagsTarget[i];
        });
      }
    }

    return res;
  }
}
