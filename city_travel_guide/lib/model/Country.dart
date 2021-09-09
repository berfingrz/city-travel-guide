class Countries {
  int countryId;
  String countryName;
  String countryImageURL;

  //Constructor
  Countries({this.countryId, this.countryName, this.countryImageURL});

  // Extract a Product Object from a Map Oject
  Countries.fromMap(Map<String, dynamic> map) {
    countryId = map['country_id'];
    countryName = map['country_name'];
    countryImageURL = map['image'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'country_id': countryId,
      'country_name': countryName,
      'image': countryImageURL
    };
    return map;
  }
}
