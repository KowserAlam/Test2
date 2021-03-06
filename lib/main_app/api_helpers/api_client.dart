import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

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
//      // temporary disable bad certificate  call back
//      HttpClient client = new HttpClient()
//        ..badCertificateCallback =
//        ((X509Certificate cert, String host, int port) => true);
//      var ioClient = new IOClient(client);
      httClient = http.Client();
    }
  }

  Future<http.Response> getRequest(String url) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    return _checkTokenValidity()
        .then((value) => httClient.get(completeUrl, headers: headers));
//    return httClient.get(completeUrl, headers: headers);
  }

  Future<http.Response> postRequest(String url, Map<String, dynamic> body,
      {Duration timeout, bool checkAccessValidity = true}) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
//    print(headers);
    if (checkAccessValidity) {
      return _checkTokenValidity().then((value) =>
          httClient.post(completeUrl, headers: headers, body: encodedBody));
    }
    return httClient.post(completeUrl, headers: headers, body: encodedBody);
  }

  Future<http.Response> putRequest(String url, Map<String, dynamic> body,
      {Duration timeout}) async {
    var completeUrl = _buildUrl(url);
    var headers = await _getHeaders();
    var encodedBody = json.encode(body);
    return _checkTokenValidity().then((value) =>
        httClient.put(completeUrl, headers: headers, body: encodedBody));

//    return httClient.put(completeUrl, headers: headers, body: encodedBody);
  }

  Future<http.StreamedResponse> postRequestWithFormData(
      String url, File file, String fileNameKey,
      [Map<String, String> fields]) async {
    var uri = Uri.parse(_buildUrl(url));
    var request = http.MultipartRequest('POST', uri);
    if (file != null) {
      request.files
          .add(await http.MultipartFile.fromPath(fileNameKey, file.path));
    }
    if (fields != null) {
      request.fields.addAll(fields);
    }
    request.headers.addAll(await _getHeaderFormData());
    return request.send();
  }

  Future<Map<String, String>> _getHeaders() async {
    var token = await AuthService.getInstance()
        .then((authService) => authService.getUser()?.accessToken);

    Map<String, String> headers = {
      'Api-Key': _apiKey,
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8',
    };

    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    return headers;
  }

  _buildUrl(String partialUrl) {
    String baseUrl = FlavorConfig.instance.values.baseUrl;
    return baseUrl + partialUrl;
  }

  Future<bool> _checkTokenValidity() async {
    var authService = await AuthService.getInstance();
    if (!authService.isAccessTokenValid())
      return authService.refreshToken();
    else {
      return true;
    }
  }

  Future<Map<String, String>> _getHeaderFormData() async {
    var token = await AuthService.getInstance()
        .then((authService) => authService.getUser()?.accessToken);

    Map<String, String> headers = {
      'Api-Key': _apiKey,
      "Content-Type": "multipart/form-data",
    };

    if (token != null)
      headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    return headers;
  }
}
