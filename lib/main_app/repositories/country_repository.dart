import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache/flutter_cache.dart';
import 'package:logger/logger.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';

class CountryRepository {
//  Future<String> getCountryNameFromCode(String code) async {
//    try {
//      var list = await getList();
//      return list.firstWhere((element) => element.id == code).text;
//    } catch (e) {
//      print(e);
//      return code;
//    }
//  }

  Future<List<Country>> getList() async {
    try {
    List<Country> _list = [];
    var decodedJson = await Cache.load(Urls.countryListUrl).then((value) async {
      if (value != null) {
        debugPrint("Country list from cache");
        return json.decode(value);
      } else {
        var res = await ApiClient().getRequest(Urls.countryListUrl);
        print(res.statusCode);
        print(res.body);
        var body = utf8.decode(res.bodyBytes);
        var data = json.decode(body);
        Cache.remember(Urls.countryListUrl, body, 43800 * 60);
        debugPrint("Country list from server");
        return data;
      }
    });
//      Logger().i(decodedJson);
    decodedJson.forEach((element) {
      _list.add(Country.fromJson(element));
    });

    return _list;
    } catch (e) {
      print(e);
      return [];
    }
  }


}

class Country extends Equatable {
  String text;
  String id;

  Country({this.text, this.id});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      text: json["text"],
      id: json["id"],
    );
  }

  @override
  String toString() {
    return text;
  }

  @override
  // TODO: implement props
  List<Object> get props => [text, id];
}
