import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/features/auth/view_models/password_reset_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';


class MockApiClient extends Mock implements ApiClient {}
main() {
  var client = MockApiClient();
  var passwordResetViewModel = PasswordResetViewModel();
  setUp(() {});

  group("validateEmailLocal", () {
    test("Testing with valid email,", () {
      passwordResetViewModel.validateEmailLocal("shofi@ishraak.com");
      expect(passwordResetViewModel.emailErrorText, null);
    });

    test("Testing with invalid valid email,", () {
      passwordResetViewModel.validateEmailLocal("email");
      expect(passwordResetViewModel.emailErrorText, StringUtils.pleaseEnterAValidEmailText);
    });

  });

  group("sendResetPasswordLink", () {

//    test("When request succes, should return ture", () async{
//      var data = {'status':"ok"};
//
//          when(client.postRequest(Urls.passwordResetUrl, {"email": "email@example.com"}))
//        .thenAnswer((_) async => http.Response(json.encode(data), 200));
//
//     bool res = await passwordResetViewModel.sendResetPasswordLink(apiClient: client);
//      expect(res, true);
//    });


    test("When request failed, should return false", () async{
      var data = {'status':"ok"};
      when(client.postRequest(Urls.passwordResetUrl, {"email": "email@example.com"}))
          .thenAnswer((_) async => http.Response(json.encode(data), 403));
      bool res = await passwordResetViewModel.sendResetPasswordLink(apiClient: client);
      expect(res, false);
    });


  });





}
