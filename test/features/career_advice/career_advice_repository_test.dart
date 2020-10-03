import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/features/career_advice/repositories/c_a_repository.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/models/web_settings_model.dart';
import 'package:p7app/features/settings/repositories/web_setting_repository.dart';

import '../../test_data/dataReader.dart';
import '../auth/password_reset_view_model_test.dart';



main() {



  var client = MockApiClient();
  Uint8List responseJsonSuccess;
  //arrange
  setUp(() async {
    responseJsonSuccess =
    await TestDataReader().readDataUtf8("career_advice_test_data.json");
  });

//  test("Career Advice repository test,Should return valid data", () async{
//    when(client.getRequest("${Urls.careerAdviceUrl}/?page_size=10&page=1"))
//        .thenAnswer((_) async => http.Response(utf8.decode(responseJsonSuccess), 200));
//    ;
//    var res = await CareerAdviceRepository().getData(apiClient: client);
//    expect( true, res.isRight());
//  });

  test("Career Advice test,Should return Left as error", () async{

    when(client.getRequest("${Urls.careerAdviceUrl}/?page_size=10&page=1"))
        .thenAnswer((_) async => http.Response("{"":""}", 401));
    ;
    var res = await CareerAdviceRepository().getData(apiClient: client);
    expect( true, res.isLeft());
  });
}
