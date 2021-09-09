class Comments {
  int id;
  String userName;
  String userComment;
  String avatar;

  //Constructor
  Comments({this.userName, this.userComment, this.avatar});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["userName"] = userName;
    map["userComment"] = userComment;
    map["avatar"] = avatar;
    return map;
  }

  Comments.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    userName = map["userName"];
    userComment = map["userComment"];
    avatar = map["avatar"];
  }
}
