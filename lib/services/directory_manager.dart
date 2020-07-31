import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

class DirectoryManager {
  //Singleton
  Directory _appDocsDir;

  static final DirectoryManager _instance =
      DirectoryManager._privateConstructor();

  factory DirectoryManager() {
    return _instance;
  }

  DirectoryManager._privateConstructor() {
    setDirectory();
  }

  void setDirectory() async {
    WidgetsFlutterBinding.ensureInitialized();
    _appDocsDir = await getApplicationDocumentsDirectory();
  }

  File fileFromDocsDir(String filename) {
    String pathName = p.join(_appDocsDir.path, filename);
    return File(pathName);
  }
}
