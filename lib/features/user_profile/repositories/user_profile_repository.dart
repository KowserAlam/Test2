import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:p7app/main_app/resource/strings_utils.dart';

class UserProfileRepository {
  Future<Either<AppError, UserModel>> getUserData() async {
    try {
      var authUser = await AuthService.getInstance();
      var professionalId = authUser.getUser().professionalId;
      debugPrint(professionalId);
      var url = "${Urls.userProfileUrl}/$professionalId";
      var response = await ApiClient().getRequest(url);
      print(response.statusCode);
      var mapJson = json.decode(response.body);
//      var mapJson = json.decode(dummyData);
      var userModel = UserModel.fromJson(mapJson);

      return Right(userModel);
    } on SocketException catch (e) {
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      print(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, UserPersonalInfo>> updateUserBasicInfo(
      Map<String, dynamic> body) async {
    BotToast.showLoading();
    var authUser = await AuthService.getInstance();
    var professionalId = authUser.getUser().professionalId;
    var url = "${Urls.userProfileUpdateUrlPartial}/$professionalId/";

    try {
      var response = await ApiClient().putRequest(url, body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        UserPersonalInfo data =
            UserPersonalInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ReferenceData data = ReferenceData.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ReferenceData data = ReferenceData.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        SkillInfo data = SkillInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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

//    print(data);

    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        SkillInfo data = SkillInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserSkill(SkillInfo skillInfo) async {
    BotToast.showLoading();
    var url = "${Urls.professionalSkillUrl}/${skillInfo.profSkillId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        MembershipInfo data =
            MembershipInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        MembershipInfo data =
            MembershipInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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

    try {
      var response = await ApiClient().postRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        EduInfo data = EduInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        EduInfo data = EduInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deleteUserEducation(
      EduInfo edInfo) async {
    BotToast.showLoading();
    var url =
        "${Urls.professionalEducationUrl}/${edInfo.educationId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        CertificationInfo data =
            CertificationInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        CertificationInfo data =
            CertificationInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().postRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ExperienceInfo data =
        ExperienceInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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

    var data = experienceInfo.toJson();
    data.addAll({"professional_id": professionalId});

    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        ExperienceInfo data =
        ExperienceInfo.fromJson(json.decode(response.body));
        return Right(data);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
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
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }

  //Portfolio
  Future<Either<AppError, PortfolioInfo>> updateUserPortfolioInfo(
      Map<String, dynamic> data, String portfolioId) async {
    BotToast.showLoading();

    var url = "${Urls.professionalPortfolioUrl}/$portfolioId/";
    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        PortfolioInfo port =
        PortfolioInfo.fromJson(json.decode(response.body));
        return Right(port);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, PortfolioInfo>> createPortfolioInfo(
      Map<String, dynamic> data) async {
    BotToast.showLoading();

    var url = "${Urls.professionalPortfolioUrl}/";
    try {
      var response = await ApiClient().postRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        PortfolioInfo port =
        PortfolioInfo.fromJson(json.decode(response.body));
        return Right(port);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }

  Future<Either<AppError, bool>> deletePortfolio(
      PortfolioInfo portfolio) async {
    BotToast.showLoading();
    var url =
        "${Urls.professionalPortfolioUrl}/${portfolio.portfolioId}/";
    var data = {"is_archived": true};

    try {
      var response = await ApiClient().putRequest(url, data);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        return Right(true);
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return Left(AppError.unknownError);
      }
    } on SocketException catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.networkError);
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      return left(AppError.serverError);
    }
  }
}

//var dummyData = """ {
//    "personal_info": {
//        "id": "c8eb21a2-0bb6-46ec-add6-0de5336e1723",
//        "professional_id": null,
//        "full_name": "Bill Gates",
//        "email": "bill@ishraak.com",
//        "phone": "01940469959",
//        "address": "Dhaka, Bangladesh",
//        "about_me": "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.",
//        "image": null,
//        "terms_and_condition_status": true,
//        "password": "pbkdf2_sha256\$180000\$kOXQcDfnrT9w\$sNxPnGUAH3slWwsXhJMjfMXDB8qud7ZPIYMjEZZ/w7I=",
//        "signup_verification_code": "",
//        "father_name": "M.A.Jabbar",
//        "mother_name": "Mirjadi Sebrina Flora",
//        "facebbok_id": "https://www.facebook.com/public/Bill-Gates",
//        "twitter_id": "https://twitter.com/BillGates",
//        "linkedin_id": null,
//        "date_of_birth": "2020-04-11",
//        "expected_salary_min": "20000.00",
//        "expected_salary_max": "50000.00",
//        "permanent_address": null,
//        "industry_expertise": null,
//        "user": 39,
//        "gender": null,
//        "status": null,
//        "experience": "System Analyst",
//        "qualification": "System Analyst",
//        "nationality": null,
//        "religion": null
//    },
//    "edu_info": [
//        {
//            "education_id": 1,
//            "qualification": "Bachelor of Science",
//            "institution": "Howard University",
//            "cgpa": null,
//            "major": null,
//            "enrolled_date": null,
//            "graduation_date": null
//        },
//        {
//            "education_id": 2,
//            "qualification": null,
//            "institution": null,
//            "cgpa": "5.00",
//            "major": null,
//            "enrolled_date": null,
//            "graduation_date": null
//        }
//    ],
//    "skill_info": [
//        {
//            "prof_skill_id": 1,
//            "skill": "Python ",
//            "rating": 5,
//            "verified_by_skillcheck": false
//        },
//        {
//            "prof_skill_id": 2,
//            "skill": 2,
//            "rating": 0,
//            "verified_by_skillcheck": false
//        }
//    ],
//    "experience_info": [
//        {
//            "experience_id": 1,
//            "company": "Ishraak Solutions",
//            "designation": "System Analyst",
//            "Started_date": null,
//            "end_date": null
//        }
//    ],
//    "portfolio_info": [
//        {
//            "portfolio_id": 1,
//            "name": "This is portfolio title",
//            "image": "https://miro.medium.com/max/700/1*NW5Hhpv4Gckxynr5U-MZwA.jpeg",
//            "description": "This is portfolio descripsion"
//        }
//    ],
//    "membership_info": [
//        {
//            "membership_id": 1,
//            "org_name": "IEE",
//            "position_held": "Member",
//            "membership_ongoing": false,
//            "Start_date": null,
//            "end_date": null,
//            "desceription": null
//        }
//    ],
//    "certification_info": [
//        {
//            "certification_id": 1,
//            "certification_name": "AWS DevOps",
//            "organization_name": "AWS",
//            "has_expiry_period": true,
//            "issue_date": null,
//            "expiry_date": null,
//            "credential_id": null,
//            "credential_url": null
//        }
//    ],
//    "reference_data": [
//        {
//            "reference_id": 1,
//            "name": "Robertson",
//            "current_position": "Software Engineer",
//            "email": null,
//            "mobile": null
//        },
//        {
//            "reference_id": 2,
//            "name": "robert",
//            "current_position": null,
//            "email": null,
//            "mobile": null
//        }
//    ]
//}
// """;
