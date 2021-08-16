import 'NetUtils.dart';

class OperationUtils {
  static Future postLike(String postId) async {
    if (postId != null)
      NetUtils.put('https://api.cc98.org/post/' + postId + '/like', data: 1);
  }

  static Future postDislike(String postId) async {
    if (postId != null)
      NetUtils.put('https://api.cc98.org/post/' + postId + '/like', data: 2);
  }

  static postReply(Map<String, dynamic> params) {
    NetUtils.post('', params);
  }

  static postWrite() {}
}
