class BasicUser {
  int id;
  String name;
  String portraitUrl;

  BasicUser({this.id, this.name, this.portraitUrl});

  factory BasicUser.fromJson(Map<String, dynamic> json) {
    return BasicUser(
        id: json['id'], name: json['name'], portraitUrl: json['portraitUrl']);
  }
}

class User {
  int id;
  String name;
  int postCount;
  int prestige; //威望
  String registerTime;
  String lastLogOnTime;
  String portraitUrl;
  String signatureCode;
  int gender;
  int wealth; //财富值
  int fanCount; //粉丝数量
  int followCount;
  bool isFollowing;
  int receivedLikeCount; //收到的赞
  int popularity; //风评
  String levelTitle; //等级
  String introduction; // 和signatureCode一样， 另外一条个性签名？

  User({
    this.id,
    this.name,
    this.postCount,
    this.prestige,
    this.registerTime,
    this.lastLogOnTime,
    this.portraitUrl,
    this.signatureCode,
    this.gender,
    this.wealth,
    this.fanCount,
    this.followCount,
    this.isFollowing,
    this.receivedLikeCount,
    this.popularity,
    this.levelTitle,
    this.introduction,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        postCount: json['postCount'],
        prestige: json['prestige'],
        registerTime: json['registerTime'],
        lastLogOnTime: json['lastLogOnTime'],
        portraitUrl: json['portraitUrl'],
        signatureCode: json['signatureCode'],
        gender: json['gender'],
        wealth: json['wealth'],
        fanCount: json['fanCount'],
        followCount: json['followCount'],
        isFollowing: json['isFollowing'],
        receivedLikeCount: json['receivedLikeCount'],
        popularity: json['popularity'],
        levelTitle: json['levelTitle'],
        introduction: json['introduction']);
  }
}
