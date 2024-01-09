class WhiteNoise {
  int whiteNoiseID;
  String imgUrl;
  String fileLocation;

  WhiteNoise({this.whiteNoiseID, this.imgUrl, this.fileLocation});

  Map<String, dynamic> toMap() {
    return {
      'whiteNoiseID': whiteNoiseID,
      'imgUrl': imgUrl,
      'fileLocation': fileLocation,
    };
  }
  Map<String, dynamic> toJson() {
    return toMap();
  }
  factory WhiteNoise.fromJson(Map<String, dynamic> json) {
    return WhiteNoise(
      whiteNoiseID: json['whiteNoiseID'],
      imgUrl: json['imgUrl'],
      fileLocation: json['fileLocation'],
    );
  }
}