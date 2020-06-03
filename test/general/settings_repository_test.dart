import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/models/settings_model.dart';
import 'package:p7app/main_app/repositories/setting_repository.dart';

import '../features/auth/password_reset_view_model_test.dart';
import '../test_data/dataReader.dart';

main() {
  var client = MockApiClient();
  String responseJsonSuccess;
  //arrange
  setUp(() async {
    responseJsonSuccess =
    await TestDataReader().readData("settings_data.json");
  });

  test("Setting repository test,Should return valid data", () async{

    when(client.getRequest(Urls.settingsUrl))
        .thenAnswer((_) async => http.Response(responseJsonSuccess, 200));
    ;
    var res = await SettingsRepository().getSettingInfo(apiClient: client);
    expect( true, res.isRight());
  });

  test("Setting repository test,Should return Left as error", () async{

    when(client.getRequest(Urls.settingsUrl))
        .thenAnswer((_) async => http.Response(responseJsonSuccess, 401));
    ;
    var res = await SettingsRepository().getSettingInfo(apiClient: client);
    expect( true, res.isLeft());
  });
}
