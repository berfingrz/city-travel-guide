class City {
  int countryId;
  int cityId;
  String cityName;
  String cityImageURL;

  //Constructor
  City({this.cityId, this.countryId, this.cityName, this.cityImageURL});

  // Extract a Product Object from a Map Oject
  City.fromMap(Map<String, dynamic> map) {
    countryId = map['country_id'];
    cityId = map['city_id'];
    cityName = map['city_name'];
    cityImageURL = map['image'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'city_id': cityId,
      'country_id': countryId,
      'city_name': cityName,
      'image': cityImageURL
    };
    return map;
  }
}
