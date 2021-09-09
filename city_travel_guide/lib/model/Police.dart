class Police {
  int categoriesId;
  int stationId;
  String stationName;
  String stationLocation;
  var telephone;
  double ltd;
  double lng;

  //Constructor
  Police(
      {this.categoriesId,
      this.stationId,
      this.stationLocation,
      this.stationName,
      this.telephone,
      this.lng,
      this.ltd});

  // Extract a Product Object from a Map Oject
  Police.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    stationId = map['station_id'];
    stationName = map['station_name'];
    stationLocation = map['station_location'];
    telephone = map['telephone_number'];
    ltd = map['latitude'];
    lng = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'station_id': stationId,
      'station_name': stationName,
      'station_location': stationLocation,
      'telephone_number': telephone,
      'latitude': ltd,
      'longitude': lng
    };

    return map;
  }
}
