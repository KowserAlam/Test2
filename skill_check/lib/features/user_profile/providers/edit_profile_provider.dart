import 'dart:io';

import 'package:flutter/cupertino.dart';

class EditProfileProvider with ChangeNotifier{

  File _fileProfileImage;
  String _assetProfileImage;
  String _networkProfileImage;
  bool _isBusyImageCrop = false;

  File get fileProfileImage => _fileProfileImage??null;

  set fileProfileImage(File value) {
    _fileProfileImage = value;
    notifyListeners();
  }

  String get assetProfileImage => _assetProfileImage??null;

  set assetProfileImage(String value) {
    _assetProfileImage = value;
    notifyListeners();
  }

  String get networkProfileImage => _networkProfileImage??null;

  set networkProfileImage(String value) {
    _networkProfileImage = value;
    notifyListeners();
  }

  bool get isBusyImageCrop => _isBusyImageCrop;

  set isBusyImageCrop(bool value) {
    _isBusyImageCrop = value;
    notifyListeners();
  }


}