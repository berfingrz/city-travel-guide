class Categories {
  int townId;
  int categoriesId;
  String categoriesName;
  String categoriesImageURL;

  //Constructor
  Categories(
      {this.categoriesId,
      this.townId,
      this.categoriesName,
      this.categoriesImageURL});

  // Extract a Product Object from a Map Oject
  Categories.fromMap(Map<String, dynamic> map) {
    townId = map['town_id'];
    categoriesId = map['categories_id'];
    categoriesName = map['categories_name'];
    categoriesImageURL = map['image'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'town_id': townId,
      'categories_name': categoriesName,
      'image': categoriesImageURL
    };
    return map;
  }
}
