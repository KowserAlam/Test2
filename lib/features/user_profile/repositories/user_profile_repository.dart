import 'dart:convert';

import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class UserProfileRepository {
  Future<Either<AppError, UserModel>> getUserData() async {
//    try {
      var authUser = await AuthService.getInstance();
      var userId = authUser.getUser().userId;
      var url = "${Urls.userProfileUrl}/$userId";

      var response = await  ApiClient().getRequest(url);

//      var response = await http.get("${Urls.userProfileUrl}/$userId");
//      var mapJson = json.decode(response.body);
      var mapJson = json.decode(dummyData);
      var userModel = UserModel.fromJson(mapJson);

      return Right(userModel);
//    } catch (e) {
//      return left(AppError.serverError);
//    }
  }

   var dummyData = """ 
   {
    "personal_info": {
        "id": "c8eb21a2-0bb6-46ec-add6-0de5336e1723",
        "professional_id": null,
        "full_name": "shofi",
        "email": "shofi@ishraak.com",
        "phone": "01940469959",
        "address": null,
        "about_me": null,
        "image": null,
        "terms_and_condition_status": true,
        "password": "pbkdf2_sha256\$180000\$kOXQcDfnrT9w\$sNxPnGUAH3slWwsXhJMjfMXDB8qud7ZPIYMjEZZ/w7I=",
        "signup_verification_code": "",
        "father_name": "M.A.Jabbar",
        "mother_name": "Mirjadi Sebrina Flora",
        "facebbok_id": null,
        "twitter_id": null,
        "linkedin_id": null,
        "date_of_birth": "2020-04-11",
        "expected_salary_min": "20000.00",
        "expected_salary_max": "50000.00",
        "industry_expertise": null,
        "user": 39,
        "gender": null,
        "status": null,
        "experience": null,
        "qualification": null,
        "nationality": null
    },
    "edu_info": [
        {
            "qualification": "Hsc",
            "institution": "None",
            "cgpa": "None",
            "major": "None",
            "enrolled_date": null,
            "graduation_date": null
        }
    ],
    "skill_info": [
        {
            "skill": "1",
            "rating": 0,
            "verified_by_skillcheck": "False"
        },
        {
            "skill": "2",
                     "rating": 2,
            "verified_by_skillcheck": "False"
        }
    ],
    "experiecnce_info": [
        {
            "company": "infolytyx",
            "designation": "system analyst",
            "Started_date": null,
            "end_date": null
        }
    ],
    "portfolio_info": [
        {
            "name": "machine god",
            "image": "None",
            "description": "hello hello"
        }
    ],
    "membership_info": [
        {
            "org_name": "1",
            "position_held": "member",
            "membership_ongoing": "False",
            "Start_date": "None",
            "end_date": "None",
            "desceription": "None"
        }
    ],
    "certification_info": [
        {
            "certification_name": "2",
            "organization_name": "2",
            "has_expiry_period": "True",
            "issue_date": "None",
            "expiry_date": "None",
            "credential_id": "None",
            "credential_url": "None"
        }
    ],
    "reference_data": [
        {
            "name": "robertson",
            "current_position": "None",
            "email": "None",
            "mobile": "None"
        }
    ]
}
   """;
}
