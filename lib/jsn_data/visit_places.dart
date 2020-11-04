class VisitPlaces {
  int placeId;
  String imgName;
  String placeName;


  VisitPlaces(this.placeId, this.imgName, this.placeName);

  factory VisitPlaces.fromJson(dynamic json) {
    return VisitPlaces(
      json['placeId'] as int,
      json['imgName'] as String,
      json['placeName'] as String,
    );
  }

  @override
  String toString() {
    return '{ ${this.placeId}, ${this.imgName}, ${this.placeName}}';
  }

}
