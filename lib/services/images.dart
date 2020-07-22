class PhotosModel {
  int id;
  int width;
  int height;
  String url;
  String photographer;
  String photographerUrl;
  int photographerId;
  SrcModel src;

  PhotosModel(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographerId,
      this.photographerUrl,
      this.src});

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        id: parsedJson["id"],
        width: parsedJson["width"],
        height: parsedJson["height"],
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String original;
  String portrait;
  String large;
  String landscape;
  String medium;
  String small;

  SrcModel(
      {this.original,
      this.portrait,
      this.landscape,
      this.large,
      this.medium,
      this.small});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
      original: srcJson["original"],
      portrait: srcJson["portrait"],
      large: srcJson["large"],
      landscape: srcJson["landscape"],
      medium: srcJson["medium"],
      small: srcJson["small"],
    );
  }
}
