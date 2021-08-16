import 'Board.dart';
import 'User.dart';

class Topic {
  int id;
  int boardId;
  String title;
  String content; //推荐阅读 的Topic使用
  String imageUrl; //推荐阅读 的Topic使用
  String boardName; //十大 的 Topic使用 可以避免再get 一个board 以及 user界面中也可以使用
  String authorName; ////十大 的 Topic使用 可以避免再get 一个user
  int authorUserId; //十大 的 Topic使用 可以避免再get 一个user
  String time;
  int userId;
  String userName;
  bool isAnonymous;
  bool disableHot;
  String lastPostTime;
  int state;
  int type;
  int replyCount;
  int hitCount;
  int totalVoteUserCount;
  String lastPostUser;
  String lastPostContent;
  int topState;
  int bestState;
  bool isVote;
  bool isPostOnly;
  int allowedViewState;
  int dislikeCount;
  int likeCount;
  String highlightInfo;
  int tag1;
  int tag2;
  bool isInternalOnly;
  bool notifyPoster;
  bool isMe;
  int todayCount;

  Topic({
    this.id,
    this.boardId,
    this.title,
    this.time,
    this.userId,
    this.imageUrl,
    this.authorUserId,
    this.authorName,
    this.boardName,
    this.content,
    this.userName,
    this.isAnonymous,
    this.disableHot,
    this.lastPostTime,
    this.state,
    this.type,
    this.replyCount,
    this.hitCount,
    this.totalVoteUserCount,
    this.lastPostUser,
    this.lastPostContent,
    this.topState,
    this.bestState,
    this.isVote,
    this.isPostOnly,
    this.allowedViewState,
    this.dislikeCount,
    this.likeCount,
    this.highlightInfo,
    this.tag1,
    this.tag2,
    this.isInternalOnly,
    this.notifyPoster,
    this.isMe,
    this.todayCount,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
        id: json['id'],
        boardId: json['boardId'],
        title: json['title'],
        time: json['time'],
        userId: json['userId'],
        userName: json['userName'],
        isAnonymous: json['isAnonymous'],
        disableHot: json['disableHot'],
        lastPostTime: json['lastPostTime'],
        state: json['state'],
        type: json['type'],
        replyCount: json['replyCount'],
        hitCount: json['hitCount'],
        totalVoteUserCount: json['totalVoteUserCount'],
        lastPostContent: json['lastPostContent'],
        topState: json['topState'],
        bestState: json['bestState'],
        isVote: json['isVote'],
        isPostOnly: json['isPostOnly'],
        allowedViewState: json['allowedViewState'],
        dislikeCount: json['dislikeCount'],
        likeCount: json['likeCount'],
        highlightInfo: json['highlightInfo'],
        tag1: json['tag1'],
        tag2: json['tag2'],
        isInternalOnly: json['isInternalOnly'],
        notifyPoster: json['notifyPoster'],
        isMe: json['isMe'],
        todayCount: json['todayCount'],
        content: json['content'],
        imageUrl: json['imageUrl'],
        boardName: json['boardName'],
        authorUserId: json['authorUserId'],
        authorName: json['authorName']);
  }
}

class Index {
  BasicUser user;
  Topic topic;
  Board board;
  Index(this.user, this.topic, {this.board});
}

class ForumInfo {
  List<Index> hotTopics;
  List<Topic> recommendations;
  int todayTopicCount;
  int todayCount;
  int topicCount;
  int postCount;
  int userCount;
  String userName;
  int onlineUserCount;
  String announcement;
  ForumInfo({
    this.announcement,
    this.topicCount,
    this.hotTopics,
    this.onlineUserCount,
    this.postCount,
    this.recommendations,
    this.todayCount,
    this.todayTopicCount,
    this.userCount,
    this.userName,
  });
}
