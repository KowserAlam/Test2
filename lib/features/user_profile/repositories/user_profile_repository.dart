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
//      var url = "${Urls.userProfileUrl}/$userId";
//
//      var response = await  ApiClient().getRequest(url);

//      var response = await http.get("${Urls.userProfileUrl}/$userId");
//      var mapJson = json.decode(response.body);
      var mapJson = json.decode(dummyData);
      var userModel = UserModel.fromJson(mapJson);

      return Right(userModel);
//    } catch (e) {
//      return left(AppError.serverError);
//    }
  }

   var dummyData = """ {
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
        "permanent_address": null,
        "industry_expertise": null,
        "user": 39,
        "gender": null,
        "status": null,
        "experience": null,
        "qualification": null,
        "nationality": null,
        "religion": null
    },
    "edu_info": [
        {
            "education_id": 1,
            "qualification": "Hsc",
            "institution": null,
            "cgpa": null,
            "major": null,
            "enrolled_date": null,
            "graduation_date": null
        },
        {
            "education_id": 2,
            "qualification": null,
            "institution": null,
            "cgpa": "5.00",
            "major": null,
            "enrolled_date": null,
            "graduation_date": null
        }
    ],
    "skill_info": [
        {
            "prof_skill_id": 1,
            "skill": 1,
            "rating": 0,
            "verified_by_skillcheck": false
        },
        {
            "prof_skill_id": 2,
            "skill": 2,
            "rating": 0,
            "verified_by_skillcheck": false
        }
    ],
    "experience_info": [
        {
            "experience_id": 1,
            "company": "infolytyx",
            "designation": "system analyst",
            "Started_date": null,
            "end_date": null
        }
    ],
    "portfolio_info": [
        {
            "portfolio_id": 1,
            "name": "machine god",
            "image": null,
            "description": "hello hello"
        }
    ],
    "membership_info": [
        {
            "membership_id": 1,
            "org_name": 1,
            "position_held": "member",
            "membership_ongoing": false,
            "Start_date": null,
            "end_date": null,
            "desceription": null
        }
    ],
    "certification_info": [
        {
            "certification_id": 1,
            "certification_name": 2,
            "organization_name": 2,
            "has_expiry_period": true,
            "issue_date": null,
            "expiry_date": null,
            "credential_id": null,
            "credential_url": null
        }
    ],
    "reference_data": [
        {
            "reference_id": 1,
            "name": "robertson",
            "current_position": null,
            "email": null,
            "mobile": null
        },
        {
            "reference_id": 2,
            "name": "robert",
            "current_position": null,
            "email": null,
            "mobile": null
        }
    ]
}
 """;
}
