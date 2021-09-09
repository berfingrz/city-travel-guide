class Restaurants {
  int categoriesId;
  int restaurantId;
  String restaurantName;
  String restaurantLocation;
  var telephone;
  double ltd;
  double lng;
  double score;

  //Constructor
  Restaurants(
      {this.categoriesId,
      this.restaurantId,
      this.restaurantLocation,
      this.restaurantName,
      this.telephone,
      this.lng,
      this.ltd,
      this.score});

  // Extract a Product Object from a Map Oject
  Restaurants.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    restaurantId = map['restaurant_id'];
    restaurantName = map['restaurant_name'];
    restaurantLocation = map['restauant_location'];
    telephone = map['telephone_number'];
    ltd = map['latitude'];
    lng = map['longitude'];
    score = map['score'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'restaurant_id': restaurantId,
      'restaurant_name': restaurantName,
      'restauant_location': restaurantLocation,
      'telephone_number': telephone,
      'latitude': ltd,
      'longitude': lng,
      'score': score,
    };

    return map;
  }
}
