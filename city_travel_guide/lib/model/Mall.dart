class Mall {
  int categoriesId;
  int mallId;
  int storeNumber;
  String mallName;
  String mallLocation;
  String workingHours;
  double ltd;
  double lng;

  //Constructor
  Mall(
      {this.categoriesId,
      this.mallId,
      this.mallLocation,
      this.mallName,
      this.lng,
      this.ltd,
      this.storeNumber,
      this.workingHours});

  // Extract a Product Object from a Map Oject
  Mall.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    mallId = map['mall_id'];
    mallName = map['mall_name'];
    mallLocation = map['mall_location'];
    workingHours = map['working_hours'];
    storeNumber = map['store_number'];
    ltd = map['latitude'];
    lng = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'mall_id': mallId,
      'mall_name': mallName,
      'mall_location': mallLocation,
      'working_hours': workingHours,
      'store_number': storeNumber,
      'latitude': ltd,
      'longitude': lng
    };

    return map;
  }
}
