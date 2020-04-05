import 'dart:convert';

import 'package:skill_check/features/user_profile/models/user_profile_models.dart';
import 'package:skill_check/main_app/api_helpers/api_client.dart';
import 'package:skill_check/main_app/auth_service/auth_service.dart';
import 'package:skill_check/main_app/failure/exceptions.dart';
import 'package:skill_check/main_app/failure/failure.dart';
import 'package:skill_check/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserProfileRepository {
  Future<Either<Failure, UserProfileModel>> getUserData() async {
    try {
      var authUser = await AuthService.getInstance();
      var userId = authUser.getUser().userId;
      var url = "${Urls.userProfileUrl}/$userId";

      var response = await  ApiClient().getRequest(url);

//      var response = await http.get("${Urls.userProfileUrl}/$userId");
      var mapJson = json.decode(response.body);
      var userModel = UserProfileModel.fromJson(mapJson['data']['user']);

      return Right(userModel);
    } catch (e) {
      return left(ServerExceptions());
    }
  }
}
