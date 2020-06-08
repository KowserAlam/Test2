
import 'dart:io';

import 'dart:typed_data';

class TestDataReader{
  Future<String> readData(name) async{
    var stringData = File("test_data/$name").readAsStringSync();
    return stringData;
  }
  Future<Uint8List> readDataUtf8(name) async{
    var data = File("test_data/$name").readAsBytes();
    return data;
  }
}