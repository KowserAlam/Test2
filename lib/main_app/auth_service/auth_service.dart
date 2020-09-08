import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:p7app/main_app/util/local_storage.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:p7app/main_app/util/token_refresh_scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static AuthService _instance;
  static LocalStorageService _localStorageService;

  static Future<AuthService> getInstance() async {
    if (_instance == null) {
      _instance = AuthService();
    }
    if (_localStorageService == null) {
      _localStorageService = await LocalStorageService.getInstance();
    }
    return _instance;
  }

  AuthUserModel getUser() {
    var userMap = _localStorageService.getString(JsonKeys.user);
//    debugPrint("UserMap: ${userMap}");
    if (userMap == null) {
      // update auth status in auth view model !
      locator<AuthViewModel>().user = null;
      return null;
    }
//    return AuthUserModel.fromJson(json.decode(userMap));

    var user = AuthUserModel.fromJsonLocal(json.decode(userMap));

    // update auth status in auth view model !
    locator<AuthViewModel>().user = user;
    return user;
  }

  Future<bool> saveUser(Map<String, dynamic> data) {
    var encodedData = json.encode(data);
    return _localStorageService.saveString(JsonKeys.user, encodedData).then((value){
      getUser();
      return value;
    });
  }

  Future<bool> removeUser() {
    _instance = AuthService();
    // update auth status in auth view model !
    locator<AuthViewModel>().user = null;
    return _localStorageService.remove(JsonKeys.user);
  }

  Future<bool> _setJwt(String jwt) async {
    var user = _instance.getUser();
    user.accessToken = jwt;
    var data = user.toJson();
//    debugPrint("_setJwt ${data}");
    return _instance.saveUser(data);
  }

  String _getAssessToken() {
    var user = _instance.getUser();
    if (user?.userId == null || user?.professionalId == null) {
      return null;
    }
    return user.accessToken;
  }

  String _getRefreshToken() {
    var user = _instance.getUser();
    if (user == null) {
      return null;
    }
    return user.refresh;
  }

  Duration getRefreshInterval() {
    DateTime expTime;
    String token = _instance._getAssessToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
//        var isValid = DateTime.now().isBefore(expTime);
        return expTime.difference(DateTime.now());
      }

      return null;
    } else {
      return null;
    }
  }

  bool isAccessTokenValid() {
    // _isRefreshTokenValid();
    DateTime expTime;
    String token = _instance._getAssessToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        var isValid = DateTime.now().isBefore(expTime);

        logger.i({
          " AccessTokenExpTime": expTime?.toString(),
          " TimeDiff": expTime.difference(DateTime.now()).inMinutes,
          "isValid": isValid,
        });
        return isValid;
      }

      return false;
    } else {
      return false;
    }
  }

  bool _isRefreshTokenValid() {
    DateTime expTime;
    String token = _getRefreshToken();
    if (token != null) {
      var payload = Jwt.parseJwt(token);
      debugPrint(payload.toString());
      if (payload['exp'] != null) {
        expTime = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
        var isValid = DateTime.now().isBefore(expTime);
        logger.i({
          "RefreshTokenExpTime": expTime?.toString(),
          " TimeDiff": expTime.difference(DateTime.now()).inMinutes,
          "isValid": isValid,
        });
        return isValid;
      }

      return false;
    } else {
      return false;
    }
  }

  Future<bool> refreshToken() async {
    if (_isRefreshTokenValid()) {
      try {
        var baseUrl = FlavorConfig.instance.values.baseUrl;
        String rfToken = _instance._getRefreshToken();
        var body = {"refresh": rfToken};
        logger.i(body);
        var res = await ApiClient()
            .postRequest(Urls.jwtRefreshUrl, body, checkAccessValidity: false);
//        var res = await http.post("${baseUrl}${Urls.jwtRefreshUrl}",body: body);
//         logger.i(res.statusCode);
        logger.i(res.body);
        if (res.statusCode == 200) {
          var data = json.decode(res.body);
          debugPrint("Token refreshed: {${res.body}");

          return _instance._setJwt(data['access']).then((value) {
            return value ? true : false;
          });
        } else {
          return false;
        }
      } catch (e) {
        logger.i(e);
        return false;
      }
    } else {
      return false;
    }
  }

//  Future<bool> checkIfLoggedIn() async {
//    SharedPreferences localStorage = await SharedPreferences.getInstance();
//    var token = localStorage.getString('token');
//    if (token != null)
//      return true;
//    else
//      return false;
//  }

}
