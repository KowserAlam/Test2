import 'dart:convert';
import 'dart:io';

import 'package:assessment_ishraak/main_app/api_helpers/urls.dart';
import 'package:assessment_ishraak/main_app/auth_service/auth_service.dart';
import 'package:assessment_ishraak/main_app/flavour/flavour_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum ApiUrlType {
  login,
  signUp,
}

class ApiClient {
  var _apiKey = "96d56aceeb9049debeab628ac760aa11";
  http.Client httClient;
  AuthService _authService = AuthService();

  ApiClient({this.httClient}) {
    if (httClient == null) {
      httClient = http.Client();
    }
  }

  Future<http.Response> getRequest(String url) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    return httClient.get(completeUrl, headers: headers);
  }

  Future<http.Response> postRequest(
      String url, Map<String, dynamic> body) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return httClient.post(completeUrl, headers: headers, body: encodedBody);
  }

  Future<Map<String, String>> _getHeaders() async {
    var token = await AuthService.getInstance()
        .then((authService) => authService.getUser()?.accessToken);

    Map<String, String> headers = {
      'Api-Key': _apiKey,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) headers.addAll({HttpHeaders.authorizationHeader: token});
    return headers;
  }

  _buildUrl(String partialUrl) {
    String baseUrl = FlavorConfig().values.baseUrl;
    return baseUrl + partialUrl;
  }
}
