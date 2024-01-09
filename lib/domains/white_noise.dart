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
}