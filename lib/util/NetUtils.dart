import 'package:dio/dio.dart';
import 'dart:async';

import '../pages/Login.dart';

class Api {
  static const String Base_api = 'https://api.cc98.org';
  static const String Openid = 'https://openid.cc98.org';

  static const String DailyHot = '/config/index';
  static const String WeeklyHot = '/topic/hot-weekly';
  static const String MonthlyHot = '/topic/hot-monthly';
  static const String HistoryHot = '/topic/hot-history';

  static const String New = '/topic/new';

  static const String ConcernBoard = '/me/custom-board/topic';
  static const String ConcernUser = '/me/followee/topic';
  static const String ConcernUpdate = '/topic/me/favorite';

  static const String Section = '/Board/all';

  static const String Me = '/me';

  static const String User = '/user';
  static const String UserId = '/user/id';
  static const String UserTopic = '/recent-topic';
  static const String Board = '/board';
  static const String Topic = '/topic';
  static const String BasicUser = '/user/basic';
  static const String Post = '/post';
  static const String Search = '/search';
}

var dio = new Dio(BaseOptions(headers: {
  "Authorization": token != null ? 'Bearer ' + token['access_token'] : ''
}));

class NetUtils {
  static Future get(String url, {Map<String, dynamic> params}) async {
    try {
      var response = await dio.get(url, queryParameters: params);
      //print(response.statusCode);
      return response.data;
    } catch (e) {
      print(e?.request);
      print(e?.response);
      print(e?.type);
      print(e?.error);
      print(e);
    }
  }

  static Future post(String url, Map<String, dynamic> params) async {
    try {
      var response = await dio.post(url, data: params);
      //print(response.statusCode);
      return response.data;
    } catch (e) {
      print(e?.request);
      print(e?.response);
      print(e?.type);
      print(e?.error);
      print(e);
    }
  }

  static Future put(String url, {dynamic data}) async {
    try {
      var response = await dio.put(url, data: data);
      //print(response.statusCode);
      return response.data;
    } catch (e) {
      print(e?.request);
      print(e?.response);
      print(e?.type);
      print(e?.error);
      print(e);
    }
  }
}
