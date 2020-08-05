import 'package:flutter/material.dart';

class JobScreenViewModel with ChangeNotifier{


  int _currentIndex = 0;


  void onChange(int index){
    _currentIndex = index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

//  set currentIndex(int value) {
//    _currentIndex = value;
//  }
}