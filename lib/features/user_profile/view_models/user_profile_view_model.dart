import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/models/portfolio_info.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UserProfileViewModel with ChangeNotifier {
  UserModel _userData;
  bool _isBusySaving = false;
  AppError _appError;
  bool _isBusyLoading = false;

  bool get isBusyLoading => _isBusyLoading;

  set isBusyLoading(bool value) {
    _isBusyLoading = value;
    notifyListeners();
  }


  AppError get appError => _appError;

  set appError(AppError value) {
    _appError = value;
  }

  bool get isBusySaving => _isBusySaving;

  set isBusySaving(bool value) {
    _isBusySaving = value;
    notifyListeners();
  }

  UserModel get userData => _userData ?? null;

  set userData(UserModel value) {
    _userData = value;
    notifyListeners();
  }

  set userPersonalInfo(UserPersonalInfo value) {
    _userData.personalInfo = value;
    notifyListeners();
  }

  resetState(){
     _userData = null;
     _isBusySaving = false;
     _appError = null;
     _isBusyLoading = false;
  }

  Future<bool> fetchUserData() async {
    _isBusyLoading = true;
    _appError = null;
    notifyListeners();

    var result = await UserProfileRepository().getUserData();
    return result.fold((left) {
      /// if left
      if(userData == null){
        _appError = left;
      }

      _isBusyLoading = false;

      notifyListeners();
      return false;
    }, (right) {
      /// if right

      _userData = right;
      _appError = null;
      _isBusyLoading = false;
      notifyListeners();

      return true;
    });
  }

  Future<Map<String, String>> updateUserData(UserModel user) async {
    /// update local state

    userData = user;

    /// update in remote server

    var res = Future.delayed(
      Duration(
        seconds: 1,
      ),
    );

    return res.then((v) {
      if (v == null) {
        return {
          JsonKeys.code: "200",
          JsonKeys.message: "Save Successfully",
        };
      } else {
        return {
          JsonKeys.code: "400",
          JsonKeys.message: "Save Unsuccessful",
        };
      }
    });
  }


  //Reference
  Future<bool> updateReferenceData(ReferenceData referenceData, int index){
    return UserProfileRepository().updateUserReference(referenceData).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
       userData.referenceData[index] = r;
       notifyListeners();
       return true;
      });
    });
  }

  Future<bool> addReferenceData(ReferenceData referenceData){
    return UserProfileRepository().addUserReference(referenceData).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.referenceData.add(r);
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deleteReferenceData(ReferenceData referenceData,int index ){
    return UserProfileRepository().deleteUserReference(referenceData).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.referenceData.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }



  //Skill
  Future<bool> addSkillData(SkillInfo skillInfo){
    return UserProfileRepository().addUserSkill(skillInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.skillInfo.add(r);
        notifyListeners();
        return true;
      });
    });
  }


  Future<bool> updateSkillData(SkillInfo skillInfo, int index){
    return UserProfileRepository().updateUserSkill(skillInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.skillInfo[index] = r;
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deleteSkillData(SkillInfo skillInfo,int index ){
    return UserProfileRepository().deleteUserSkill(skillInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.skillInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }


  //Membership
  Future<bool> addMembershipData(MembershipInfo membershipInfo){
    return UserProfileRepository().addUserMembership(membershipInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.membershipInfo.add(r);
        userData.membershipInfo.sort((a,b){
          if(a.startDate == null || b.startDate == null)
            return 0;
          return b.startDate.compareTo(a.startDate);
        });
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> updateMembershipData(MembershipInfo membershipInfo, int index){
    return UserProfileRepository().updateUserMembership(membershipInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.membershipInfo[index] = r;
        userData.membershipInfo.sort((a,b){
          if(a.startDate == null || b.startDate == null)
            return 0;
          return b.startDate.compareTo(a.startDate);
        });
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deleteMembershipData(MembershipInfo membershipInfo,int index ){
    return UserProfileRepository().deleteUserMembership(membershipInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.membershipInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }

  //Certification
  Future<bool> addCertificationData(CertificationInfo certificationInfo){
    return UserProfileRepository().addUserCertification(certificationInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.certificationInfo.add(r);
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> updateCertificationData(CertificationInfo certificationInfo, int index){
    return UserProfileRepository().updateUserCertification(certificationInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.certificationInfo[index] = r;
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deleteCertificationData(CertificationInfo certificationInfo,int index ){
    return UserProfileRepository().deleteUserCertification(certificationInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.certificationInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }

  //Portfolio
  Future<bool> addPortfolioInfo({ @required Map<String,dynamic> data, UserProfileRepository userProfileRepository})async{
    var repository = userProfileRepository ?? UserProfileRepository();
    var res = await repository.createPortfolioInfo(data);
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.portfolioInfo.add(r);
        notifyListeners();
        return true;
      });

  }
  Future<bool> updatePortfolio({ @required Map<String,dynamic> data,@required   int index,@required  String portfolioId}){
    return UserProfileRepository().updateUserPortfolioInfo(data,portfolioId).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.portfolioInfo[index] = r;
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deletePortfolio(PortfolioInfo portfolioInfo,int index ,{UserProfileRepository userProfileRepository}){
    var repository = userProfileRepository ?? UserProfileRepository();
    return repository.deletePortfolio(portfolioInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.portfolioInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }

  //Experience
  Future<bool> addExperienceData(ExperienceInfo experienceInfo){
    return UserProfileRepository().addUserExperience(experienceInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.experienceInfo.add(r);
        fetchUserData();
//        userData.experienceInfo.sort((a,b){
//          if(a.startDate == null || b.startDate == null)
//            return 0;
//          return b.startDate.compareTo(a.startDate);});
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> updateExperienceData(ExperienceInfo experienceInfo, int index){
    return UserProfileRepository().updateUserExperience(experienceInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.experienceInfo[index] = r;
//        userData.experienceInfo.sort((a,b){
//          if(a.startDate == null || b.startDate == null)
//            return 0;
//          return b.startDate.compareTo(a.startDate);});
        fetchUserData();
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> deleteExperienceData(ExperienceInfo experienceInfo,int index ){
    return UserProfileRepository().deleteUserExperience(experienceInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.experienceInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }


  //Education
  Future<bool> addEduInfo(EduInfo eduInfo){
    return UserProfileRepository().addUserEducation(eduInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.eduInfo.add(r);
        userData.eduInfo.sort((a,b){
          if(a.enrolledDate == null || b.enrolledDate == null)
            return 0;
          return b.enrolledDate.compareTo(a.enrolledDate);});
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> updateEduInfo(EduInfo eduInfo,int index){
    return UserProfileRepository().updateUserEducation(eduInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.eduInfo[index] = r;
        userData.eduInfo.sort((a,b){
          if(a.enrolledDate == null || b.enrolledDate == null)
            return 0;
          return b.enrolledDate.compareTo(a.enrolledDate);});
        notifyListeners();
        return true;
      });
    });
  }
  Future<bool> deleteEduInfo(EduInfo eduInfo,int index){
    return UserProfileRepository().deleteUserEducation(eduInfo).then((res){
      return res.fold((l){
        print(l);
        return false;
      }, (r){
        userData.eduInfo.removeAt(index);
        notifyListeners();
        return true;
      });
    });
  }

}
