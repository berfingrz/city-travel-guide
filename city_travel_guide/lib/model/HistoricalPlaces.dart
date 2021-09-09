class HistoricalPlaces {
  int categoriesId;
  int histId;
  String histName;
  String histLocaiton;
  String workingHours;
  var telephone;
  String histImageUrl;
  double ltd;
  double lng;

  //Constructor
  HistoricalPlaces(
      {this.categoriesId,
      this.histId,
      this.histImageUrl,
      this.histLocaiton,
      this.histName,
      this.lng,
      this.ltd,
      this.telephone,
      this.workingHours});

  // Extract a Product Object from a Map Oject
  HistoricalPlaces.fromMap(Map<String, dynamic> map) {
    categoriesId = map['categories_id'];
    histId = map['hist_id'];
    histName = map['hist_name'];
    histLocaiton = map['hist_location'];
    workingHours = map['working_hours'];
    telephone = map['telephone_number'];
    histImageUrl = map['image'];
    ltd = map['latitude'];
    lng = map['longitude'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categories_id': categoriesId,
      'hist_id': histId,
      'hist_name': histName,
      'hist_location': histLocaiton,
      'working_hours': workingHours,
      'telephone_number': telephone,
      'image': histImageUrl,
      'latitude': ltd,
      'longitude': lng
    };

    return map;
  }
}
