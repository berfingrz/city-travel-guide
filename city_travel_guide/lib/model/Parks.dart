class Parks {
  int categoriesId;
  int parkId;
  String parkName;
  String parkLocation;
  double ltd;
  double lng;

  //Constructor
  Parks(
      {this.categoriesId,
      this.parkId,
      this.parkLocation,
      this.parkName,
      this.lng,
      this.ltd});

  // Extract a Product Object from a Map Oject
  Parks.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    parkId = map['park_id'];
    parkName = map['park_name'];
    parkLocation = map['park_location'];
    ltd = map['latitude'];
    lng = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'park_id': parkId,
      'park_name': parkName,
      'park_location': parkLocation,
      'latitude': ltd,
      'longitude': lng
    };

    return map;
  }
}
