class Town {
  int cityId;
  int townId;
  String townName;
  String townImageURL;

  //Constructor
  Town({this.townId, this.cityId, this.townName, this.townImageURL});

  // Extract a Product Object from a Map Oject
  Town.fromMap(Map<String, dynamic> map) {
    cityId = map['city_id'];
    townId = map['town_id'];
    townName = map['town_name'];
    townImageURL = map['image'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'town_id': townId,
      'city_id': cityId,
      'town_name': townName,
      'image': townImageURL
    };
    return map;
  }
}
