import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/auth_service/auth_user_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';

class UserProfileRepository {
  Future<Either<AppError, UserModel>> getUserData() async {
    try {
      var authUser = await AuthService.getInstance();
      var professionalId = authUser.getUser().professionalId;
      debugPrint(professionalId);

      var url = "${Urls.userProfileUrl}/";
      var response = await ApiClient().getRequest(url);
//      logger.i(response.statusCode);
//      logger.i(response.body);

      if (response.statusCode == 200) {
        var mapJson = json.decode(response.body);
//      var mapJson = json.decode(dummyData);
//        Logger().i(mapJson);
        var userModel = UserModel.fromJson(mapJson);
        return Right(userModel);
      } else {
        return left(AppError.httpError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      return left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      BotToast.showText(text: StringResources.somethingIsWrong);
      return left(AppError.serverError);
    }
  }

  _updateLocalInfo(UserPersonalInfo user, String imageUrl) async {
    AuthUserModel authUserModel =
        await AuthService.getInstance().then((value) => value.getUser());
    authUserModel.email = user.email;
    authUserModel.fullName = user.fullName;
    logger.i(authUserModel.professionalId);

    var authService = await AuthService.getInstance();
    var data = authUserModel.toJson();
    Logger().i(data);
    authService.saveUser(data);
  }

  Future<Either<AppError, UserPersonalInfo>> updateUserBasicInfo(
      Map<String, dynamic> body) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.userProfileUpdateUrlPartial}/";

    try {
      var response = await ApiClient().putRequest(url, body);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        var decodedJson = json.decode(response.body);
        UserPersonalInfo data = UserPersonalInfo.fromJson(decodedJson);
        _updateLocalInfo(data, decodedJson['image']);
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToReachServerMessage);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Reference
  Future<Either<AppError, ReferenceData>> addUserReference(
      ReferenceData referenceData) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalReference}/";

    var data = referenceData.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ReferenceData data = ReferenceData.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, ReferenceData>> updateUserReference(
      ReferenceData referenceData) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalReference}/${referenceData.referenceId}/";

    var data = referenceData.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ReferenceData data = ReferenceData.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserReference(
      ReferenceData referenceData) async {
    BotToast.showLoading();
    var url = "${Urls.professionalReference}/${referenceData.referenceId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Skills
  Future<Either<AppError, SkillInfo>> addUserSkill(SkillInfo skillInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalSkillUrl}/";

    var data = skillInfo.toJsonCreateNew();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().postRequest(url, data);
      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        var decodedJson = json.decode(response.body);
        logger.i(decodedJson);
        SkillInfo data = SkillInfo.fromJson(decodedJson);
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, SkillInfo>> updateUserSkill(
      SkillInfo skillInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalSkillUrl}/${skillInfo.profSkillId}/";

    var data = skillInfo.toJson();
    data.addAll({"professional_id": professionalId});

//    logger.i(data);

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        SkillInfo data = SkillInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserSkill(SkillInfo skillInfo) async {
    BotToast.showLoading();
    var url = "${Urls.professionalSkillUrl}/${skillInfo.profSkillId}/";

    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
      logger.i(response.statusCode);
      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Membership
  Future<Either<AppError, MembershipInfo>> addUserMembership(
      MembershipInfo membershipInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalMembershipUrl}/";

    var data = membershipInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        MembershipInfo data =
            MembershipInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, MembershipInfo>> updateUserMembership(
      MembershipInfo membershipInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url =
        "${Urls.professionalMembershipUrl}/${membershipInfo.membershipId}/";

    var data = membershipInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        MembershipInfo data =
            MembershipInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserMembership(
      MembershipInfo membershipInfo) async {
    BotToast.showLoading();
    var url =
        "${Urls.professionalMembershipUrl}/${membershipInfo.membershipId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Education
  Future<Either<AppError, EduInfo>> addUserEducation(EduInfo eduInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalEducationUrl}/";

    var data = eduInfo.toJson();
    data.addAll({"professional_id": professionalId});
    logger.i(data);
    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
     logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();

        EduInfo data = EduInfo.fromJson(json.decode(response.body));
        data.degree = eduInfo.degree;
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, EduInfo>> updateUserEducation(EduInfo eduInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalEducationUrl}/${eduInfo.educationId}/";

    var data = eduInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        EduInfo data = EduInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserEducation(EduInfo edInfo) async {
    BotToast.showLoading();
    var url = "${Urls.professionalEducationUrl}/${edInfo.educationId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
      logger.i(response.statusCode);
      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }
  Future<Either<AppError, EduInfo>> getUserEducation(int id) async {
    var url = "${Urls.professionalEducationObjUrl}/${id}/";
    debugPrint(url);

    try {
      var response = await ApiClient().getRequest(url);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {

         var decodedJson = json.decode(response.body);
        return Right(EduInfo.fromJson(decodedJson['edu_info']));
      } else {
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Certification
  Future<Either<AppError, CertificationInfo>> addUserCertification(
      CertificationInfo certificationInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalCertificationUrl}/";

    var data = certificationInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        CertificationInfo data =
            CertificationInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, CertificationInfo>> updateUserCertification(
      CertificationInfo certificationInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url =
        "${Urls.professionalCertificationUrl}/${certificationInfo.certificationId}/";

    var data = certificationInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        CertificationInfo data =
            CertificationInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserCertification(
      CertificationInfo certificationInfo) async {
    BotToast.showLoading();
    var url =
        "${Urls.professionalCertificationUrl}/${certificationInfo.certificationId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Experience
  Future<Either<AppError, ExperienceInfo>> addUserExperience(
      ExperienceInfo experienceInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.professionalExperienceUrl}/";

    var data = experienceInfo.toJson();
//    data.addAll({"professional_id": professionalId});
    logger.i(data);

    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ExperienceInfo data = ExperienceInfo();
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, ExperienceInfo>> updateUserExperience(
      ExperienceInfo experienceInfo) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url =
        "${Urls.professionalExperienceUrl}/${experienceInfo.experienceId}/";
    logger.i(url);

    var data = experienceInfo.toJson();
    data.addAll({"professional_id": professionalId});
    debugPrint(data.toString());

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();

        ExperienceInfo data = ExperienceInfo();
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserExperience(
      ExperienceInfo experienceInfo) async {
    BotToast.showLoading();
    var url =
        "${Urls.professionalExperienceUrl}/${experienceInfo.experienceId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  //Portfolio
  Future<Either<AppError, PortfolioInfo>> updateUserPortfolioInfo(
      Map<String, dynamic> data, String portfolioId) async {
    BotToast.showLoading();

    var url = "${Urls.professionalPortfolioUrl}/$portfolioId/";
    debugPrint(url);
    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        PortfolioInfo port = PortfolioInfo.fromJson(json.decode(response.body));
        return Right(port);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, PortfolioInfo>> createPortfolioInfo(
      Map<String, dynamic> data) async {
    BotToast.showLoading();

    var url = "${Urls.professionalPortfolioUrl}/";
    try {
      var response = await ApiClient().postRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        PortfolioInfo port = PortfolioInfo.fromJson(json.decode(response.body));
        return Right(port);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deletePortfolio(
      PortfolioInfo portfolio) async {
    BotToast.showLoading();
    var url = "${Urls.professionalPortfolioUrl}/${portfolio.portfolioId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
//      logger.i(response.statusCode);
//      logger.i(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringResources.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringResources.unableToSaveData);
      logger.e(e);
      return left(AppError.serverError);
    }
  }
}

