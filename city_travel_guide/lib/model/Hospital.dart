class Hospital {
  int categoriesId;
  int hospitalId;
  String hospitalName;
  String hospitalLocation;
  var telephone;
  double ltd;
  double lng;

  //Constructor
  Hospital(
      {this.categoriesId,
      this.hospitalId,
      this.hospitalLocation,
      this.hospitalName,
      this.lng,
      this.ltd,
      this.telephone});

  // Extract a Product Object from a Map Oject
  Hospital.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    hospitalId = map['hospital_id'];
    hospitalName = map['hospital_name'];
    hospitalLocation = map['hospital_location'];
    telephone = map['telephone_number'];
    ltd = map['latitude'];
    lng = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'hospital_id': hospitalId,
      'hospital_name': hospitalName,
      'hospital_location': hospitalLocation,
      'telephone_number': telephone,
      'latitude': ltd,
      'longitude': lng
    };

    return map;
  }
}
