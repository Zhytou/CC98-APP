import 'dart:async' show Future;

import '../model/Index.dart';
import '../model/Board.dart';
import '../model/Post.dart';
import '../model/User.dart';
import 'NetUtils.dart';

class DataUtils {
  //返回论坛信息
  static Future<ForumInfo> getForumInfo() async {
    List<Topic> recommendations = [];
    List<Index> hotTopics = [];

    var response = await NetUtils.get(
      Api.Base_api + Api.DailyHot,
    );

    var responseTopicList = response['hotTopic'];
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous &&
          (topic.userId != null || topic.authorUserId != null)) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {
            'id': topic.userId == null ? topic.authorUserId : topic.userId
          },
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      hotTopics.add(Index(
        user,
        topic,
      ));
    }

    var responseRecommendationTopicList = response['recommendationReading'];
    for (var i = 0; i < responseRecommendationTopicList?.length; i++) {
      Topic topic = Topic.fromJson(responseRecommendationTopicList[i]);
      var url = responseRecommendationTopicList[i]['url'];
      if (url != null) {
        List<String> tmp = url?.split('/');
        topic.id = int.parse(tmp[2]);
      }
      recommendations.add(topic);
    }

    return ForumInfo(
      hotTopics: hotTopics,
      recommendations: recommendations,
      userCount: response['userCount'],
      userName: response['lastUserName'],
      onlineUserCount: response['onlineUserCount'],
      postCount: response['postCount'],
      topicCount: response['topicCount'],
      todayCount: response['todayCount'],
      todayTopicCount: response['todayTopicCount'],
      announcement: response['announcement'],
    );
  }

  //热门
  static Future<List<Topic>> getRecommendationTopicList() async {
    List<Topic> resultList = [];
    var response = await NetUtils.get(
      Api.Base_api + Api.DailyHot,
    );
    var responseRecommendationTopicList = response['recommendationReading'];
    for (var i = 0; i < responseRecommendationTopicList?.length; i++) {
      Topic topic = Topic.fromJson(responseRecommendationTopicList[i]);
      var url = responseRecommendationTopicList[i]['url'];
      if (url != null) {
        List<String> tmp = url?.split('/');
        topic.id = int.parse(tmp[2]);
      }
      resultList.add(topic);
    }
    return resultList;
  }

  static Future<List<Index>> getDailyHotTopicList() async {
    List<Index> resultList = [];
    var response = await NetUtils.get(
      Api.Base_api + Api.DailyHot,
    );
    var responseTopicList = response['hotTopic'];

    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous &&
          (topic.userId != null ||
              (topic.authorUserId != null && topic.authorUserId != -1))) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {
            'id': topic.userId == null ? topic.authorUserId : topic.userId
          },
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      resultList.add(Index(
        user,
        topic,
      ));
    }
    return resultList;
  }

  static Future<List<Index>> getWeeklyHotTopicList() async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.WeeklyHot,
    );

    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous &&
          (topic.userId != null || topic.authorUserId != null)) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {
            'id': topic.userId == null ? topic.authorUserId : topic.userId
          },
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  static Future<List<Index>> getMonthlyHotTopicList() async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.MonthlyHot,
    );

    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous &&
          (topic.userId != null || topic.authorUserId != null)) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {
            'id': topic.userId == null ? topic.authorUserId : topic.userId
          },
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  static Future<List<Index>> getHistoryHotTopicList() async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.HistoryHot,
    );

    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous &&
          (topic.userId != null || topic.authorUserId != null)) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {
            'id': topic.userId == null ? topic.authorUserId : topic.userId
          },
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  //返回新帖
  static Future<List<Index>> getNewTopicList(
      Map<String, dynamic> params) async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.New,
      params: params,
    );
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': topic.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  //返回关注版面 的信息
  static Future<List<Index>> getConcernBoardTopicList(
      Map<String, dynamic> params) async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.ConcernBoard,
      params: params,
    );
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': topic.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  //返回关注用户 的信息
  static Future<List<Index>> getConcernUserTopicList(
      Map<String, dynamic> params) async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.ConcernUser,
      params: params,
    );
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': topic.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      var responseBoard = await NetUtils.get(
        Api.Base_api + Api.Board + '/${topic.boardId}',
      );
      Board board = new Board.fromJson(responseBoard);

      resultList.add(Index(
        user,
        topic,
        board: board,
      ));
    }
    return resultList;
  }

  //返回关注更新 的信息
  static Future<List<Index>> getConcernUpdateTopicList(
      Map<String, dynamic> params) async {
    List<Index> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.ConcernUpdate,
      params: params,
    );
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = new Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': topic.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      resultList.add(Index(
        user,
        topic,
      ));
    }
    return resultList;
  }

  //返回全部版面 信息
  static Future<List<Block>> getSectionList() async {
    List<Block> resultList = [];
    var responseBlockList = await NetUtils.get(Api.Base_api + Api.Section);

    for (int i = 0; i < responseBlockList?.length; i++) {
      resultList.add(Block.fromJson(responseBlockList[i]));
    }
    return resultList;
  }

  //
  //
  //返回登录用户的信息
  static Future<User> getMe() async {
    var response = await NetUtils.get(
      Api.Base_api + Api.Me,
    );
    User me = User.fromJson(response);
    return me;
  }

  static Future<List<Topic>> getMyTopicList(Map<String, dynamic> params) async {
    List<Topic> resultList = [];
    var responseList = await NetUtils.get(
        'https://api.cc98.org/me/recent-topic',
        params: params);

    for (var i = 0; i < responseList?.length; i++) {
      resultList.add(Topic.fromJson(responseList[i]));
    }
    return resultList;
  }

  static Future<List<Message>> getMyReplyList(
      Map<String, dynamic> params) async {
    List<Message> resultList = [];
    var responseList = await NetUtils.get('https://api.cc98.org/me/recent-post',
        params: params);

    for (var i = 0; i < responseList['data']?.length; i++) {
      print(responseList[i]);
      resultList.add(Message.fromJson(responseList['data'][i]));
    }
    return resultList;
  }

  static Future<List<User>> getMyFans(Map<String, dynamic> params) async {
    List<User> resultList = [];
    var responseUserIdList =
        await NetUtils.get('https://api.cc98.org/me/follower', params: params);
    for (var i = 0;
        i < (responseUserIdList == null ? 0 : responseUserIdList.length);
        i++) {
      var responseUser = await NetUtils.get(
        Api.Base_api + Api.User,
        params: {'id': responseUserIdList[i]},
      );
      resultList.add(User.fromJson(responseUser[0]));
    }
    return resultList;
  }

  static Future<List<User>> getMyIdols(Map<String, dynamic> params) async {
    List<User> resultList = [];
    var responseUserIdList =
        await NetUtils.get('https://api.cc98.org/me/followee', params: params);

    for (var i = 0;
        i < (responseUserIdList == null ? 0 : responseUserIdList.length);
        i++) {
      var responseUser = await NetUtils.get(
        Api.Base_api + Api.User,
        params: {'id': responseUserIdList[i]},
      );
      resultList.add(User.fromJson(responseUser[0]));
    }
    return resultList;
  }

  static Future<List<Topic>> getMyCollections(
      Map<String, dynamic> params) async {
    List<Topic> resultList = [];
    var responseList = await NetUtils.get(
        'https://api.cc98.org/topic/me/favorite',
        params: params);

    for (var i = 0; i < responseList.length; i++) {
      resultList.add(Topic.fromJson(responseList[i]));
    }
    return resultList;
  }

  static Future<List<Topic>> getMyBrowsingHistory() {
    /*  List<Topic> resultList = [];
    var responseList;
    return resultList;
  */
  }

  static Future<Topic> getTopic(String topicId) async {
    Topic result;
    var response = await NetUtils.get(
      'https://api.cc98.org/topic/' + topicId,
    );
    result = Topic.fromJson(response);
    return result;
  }

  //返回ID为topicId的主题 发言信息
  static Future<List<Post>> getPostList(
      String topicId, Map<String, dynamic> params) async {
    List<Post> resultList = [];

    var responseMessageList = await NetUtils.get(
      Api.Base_api + Api.Topic + '/$topicId' + Api.Post,
      params: params,
    );
    for (int i = 0; i < responseMessageList.length; i++) {
      Message message = Message.fromJson(responseMessageList[i]);

      BasicUser user;
      if (!message.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': message.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }

      resultList.add(Post(message, user));
    }
    return resultList;
  }

  //返回ID为boardId的版面 信息
  static Future<Board> getBoard(String boardId) async {
    var response = await NetUtils.get(Api.Base_api + Api.Board + '/$boardId');
    Board board = Board.fromJson(response);
    return board;
  }

  //返回ID为boardId的版面 中的主题
  static Future<List<Index>> getBoardTopicList(
      String boardId, Map<String, dynamic> params) async {
    List<Index> resultList = [];

    var responseTopicList = await NetUtils.get(
        Api.Base_api + Api.Board + '/' + boardId + Api.Topic,
        params: params);
    for (var i = 0; i < responseTopicList?.length; i++) {
      Topic topic = Topic.fromJson(responseTopicList[i]);

      BasicUser user;
      if (!topic.isAnonymous) {
        var responseUser = await NetUtils.get(
          Api.Base_api + Api.BasicUser,
          params: {'id': topic.userId},
        );
        user = BasicUser.fromJson(responseUser[0]);
      } else {
        user = BasicUser(
          name: '匿名用户',
          portraitUrl:
              'https://www.cc98.org/static/images/_%E5%BF%83%E7%81%B5%E4%B9%8B%E7%BA%A6.png',
        );
      }
      resultList.add(Index(user, topic));
    }
    return resultList;
  }

  //返回ID为userId的用户 信息
  static Future<BasicUser> getBasicUser(String userId) async {
    var responseUser = await NetUtils.get(
      Api.Base_api + Api.BasicUser,
      params: {'id': userId},
    );
    return BasicUser.fromJson(responseUser[0]);
  }

  //返回ID为userId的用户 信息
  static Future<User> getUser(String userId) async {
    var response = await NetUtils.get(
      Api.Base_api + Api.User,
      params: {'id': userId},
    );
    User user = User.fromJson(response);
    return user;
  }

  //返回ID为userName的用户 信息
  static Future<User> getUserByName(String userName) async {
    var response =
        await NetUtils.get(Api.Base_api + Api.User + '/name/' + userName);
    User user = User.fromJson(response);
    return user;
  }

  //返回该用户发表的主题
  static Future<List<Topic>> getUserTopicList(
      String userId, Map<String, dynamic> params) async {
    List<Topic> resultList = [];
    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.User + '/' + userId + Api.UserTopic,
      params: params,
    );
    for (int i = 0; i < responseTopicList?.length; i++) {
      Topic topic = Topic.fromJson(responseTopicList[i]);
      resultList.add(topic);
    }
    return resultList;
  }

  //返回关键词为keyword的主题信息
  static Future<List<Topic>> getSearchTopicList(
      Map<String, dynamic> params) async {
    List<Topic> resultList = [];

    var responseTopicList = await NetUtils.get(
      Api.Base_api + Api.Topic + Api.Search,
      params: params,
    );

    for (var i = 0; i < responseTopicList?.length; i++) {
      Topic topic = Topic.fromJson(responseTopicList[i]);
      resultList.add(topic);
    }
    return resultList;
  }
}
