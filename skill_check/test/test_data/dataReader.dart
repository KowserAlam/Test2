
import 'dart:io';

class TestDataReader{
  Future<String> readData(name) async{
    var stringData = File("test_data/$name").readAsStringSync();
    return stringData;
  }
}