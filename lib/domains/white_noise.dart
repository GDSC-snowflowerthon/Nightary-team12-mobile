class WhiteNoise {
  final int whiteNoiseID;
  final String imgUrl;
  final String fileLocation;

  const WhiteNoise({
    required this.whiteNoiseID,
    required this.imgUrl,
    required this.fileLocation,
  });

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
