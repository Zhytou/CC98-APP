import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../pages/Help.dart';
import '../pages/Search.dart';
import '../pages/Write.dart';
import '../pages/Reply.dart';
import '../pages/contents/Empty.dart';
import '../pages/contents/Topic.dart';
import '../pages/contents/Board.dart';
import '../pages/contents/User.dart';

import '../pages/tabs/setting_tabs/MyProfile.dart';
import '../pages/tabs/setting_tabs/MyTopic.dart';
import '../pages/tabs/setting_tabs/MyReply.dart';
import '../pages/tabs/setting_tabs/MyFriends.dart';
import '../pages/tabs/setting_tabs/MyMessages.dart';
import '../pages/tabs/setting_tabs/MyCollections.dart';
import '../pages/tabs/setting_tabs/AboutUs.dart';

var emptyHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return EmptyPage();
  },
);

var topicHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String topicId = params['id']?.first;
    String topicTitle = params['title']?.first;
    return TopicPage(topicId, topicTitle);
  },
);

var boardHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String boardId = params['id']?.first;
    String boardName = params['name']?.first;
    return BoardPage(boardId, boardName);
  },
);

var userHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String userId = params['id']?.first;
  String userName = params['name']?.first;
  return UserPage(
    userId,
    userName: userName,
  );
});

var helpHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HelpPage();
});

var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPage();
});

var writeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WritePage();
});

var replyHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String topicId = params['topicId']?.first;
  String topicTitle = params['topicTitle']?.first;
  String quote = params['quote']?.first;
  print(topicId);
  print(topicTitle);
  print(quote);

  return ReplyPage(topicId, topicTitle, quote: quote);
});

var meHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String option = params['option']?.first;
  print(option);
  switch (option) {
    case '0':
      return MyProfilePage();
      break;
    case '1':
      return MyTopicPage();
      break;
    case '2':
      return MyReplyPage();
      break;
    case '3':
      return MyFriendsPage();
      break;
    case '4':
      return MyMessagePage();
      break;
    case '5':
      return MyCollectionsPage();
      break;
    case '7':
      return AboutUsPage();
      break;
    default:
      return EmptyPage();
  }
});
