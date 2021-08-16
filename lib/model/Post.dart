import 'User.dart';

class Award {
  int id;
  int messageId;
  String content;
  String reason;
  String operatorName;
  int type;
  String time;
}

class Message {
  int id;
  int parentId;
  int boardId;
  String userName;
  int userId;
  String title;
  String content;
  String time;
  int length;
  int topicId;
  bool isBest;
  String ip;
  int state;
  bool isAnonymous;
  String awardInfo;
  int floor;
  //List<String> allowedViewers;
  bool isAllowedOnly;
  int contentType;
  String lastUpdateTime;
  String lastUpdateAuthor;
  bool isDeleted;
  int likeCount;
  int dislikeCount;
  bool isLZ;
  int likeState;
  List<dynamic> awards;
  Message({
    //this.allowedViewers,
    this.awardInfo,
    this.awards,
    this.boardId,
    this.content,
    this.contentType,
    this.dislikeCount,
    this.floor,
    this.id,
    this.ip,
    this.isAllowedOnly,
    this.isAnonymous,
    this.isBest,
    this.isDeleted,
    this.isLZ,
    this.lastUpdateAuthor,
    this.lastUpdateTime,
    this.length,
    this.likeCount,
    this.likeState,
    this.parentId,
    this.state,
    this.time,
    this.title,
    this.topicId,
    this.userId,
    this.userName,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        //allowedViewers: json['allowedViewers'],
        awardInfo: json['awardInfo'],
        awards: json['awards'],
        boardId: json['boardId'],
        content: json['content'],
        contentType: json['contentType'],
        dislikeCount: json['dislikeCount'],
        floor: json['floor'],
        id: json['id'],
        ip: json['ip'],
        isAllowedOnly: json['isAllowedOnly'],
        isAnonymous: json['isAnonymous'],
        isBest: json['isBest'],
        isDeleted: json['isDeleted'],
        isLZ: json['isLZ'],
        lastUpdateAuthor: json['lastUpdateAuthor'],
        lastUpdateTime: json['lastUpdateTime'],
        length: json['length'],
        likeCount: json['likeCount'],
        likeState: json['likeState'],
        parentId: json['parentId'],
        state: json['state'],
        time: json['time'],
        title: json['title'],
        topicId: json['topicId'],
        userId: json['userId'],
        userName: json['userName']);
  }
}

class Post {
  Message message;
  BasicUser user;
  Post(this.message, this.user);
}
