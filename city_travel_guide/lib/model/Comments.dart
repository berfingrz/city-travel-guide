class Comments {
  int townId;
  int commentId;
  String username;
  String comment;
  String commentImageURL;
  double stars;
  int categoriesId;
  int histId;

  //Constructor
  Comments(
      {this.townId,
      this.commentId,
      this.username,
      this.comment,
      this.commentImageURL,
      this.stars,
      this.categoriesId,
      this.histId});

  // Extract a Product Object from a Map Oject
  Comments.fromMap(Map<String, dynamic> map) {
    townId = map['town_id'];
    commentId = map['comment_id'];
    username = map['name'];
    comment = map['description'];
    commentImageURL = map['image'];
    stars = map['stars'];
    categoriesId = map['categories_id'];
    histId = map['hist_id'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'town_id': townId,
      'comment_id': commentId,
      'name': username,
      'description': comment,
      'image': commentImageURL,
      'stars': stars,
      'categories_id': categoriesId,
      'hist_id': histId
    };
    return map;
  }
}
