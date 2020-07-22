import 'dart:convert';

class BannedImages {
  //Singleton
  List<int> _bannedImages;

  static final BannedImages _instance = BannedImages._privateConstructor();

  factory BannedImages() {
    return _instance;
  }

  BannedImages._privateConstructor() {
    _bannedImages = [];
    _bannedImages.add(515);
    _bannedImages.add(1667);
    _bannedImages.add(1848);
    _bannedImages.add(777); //TODO: BORRAR ESTO
  }

  void banImage(int img) {
    if (!isBanned(img)) {
      _bannedImages.add(img);
      print('the image $img was banned');
    }
  }

  bool isBanned(int img) {
    return _bannedImages.contains(img);
  }

  String lastBanned() {
    return _bannedImages.last.toString();
  }
}
