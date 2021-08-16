class Board {
  int id;
  String name;
  List<dynamic> boardMasters;
  int topicCount;
  int postCount;
  String description;
  int todayCount;

  Board({
    this.id,
    this.name,
    this.boardMasters,
    this.topicCount,
    this.postCount,
    this.description,
    this.todayCount,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'],
      name: json['name'],
      boardMasters: json['boardMasters'],
      topicCount: json['topicCount'],
      postCount: json['postCount'],
      description: json['description'],
      todayCount: json['todayCount'],
    );
  }
}

class Block {
  int id;
  String name;
  int order;
  List<dynamic> masters;
  List<dynamic> boards;

  Block({this.id, this.name, this.order, this.masters, this.boards});

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
        id: json['id'],
        name: json['name'],
        order: json['order'],
        masters: json['masters'],
        boards: json['boards']);
  }
}
