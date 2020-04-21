import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/main_app/resource/json_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UserProfileViewModel with ChangeNotifier {
  UserModel _userData;
  bool _isBusySaving = false;
  bool _hasError = false;
  bool _isBusyLoading = false;

  bool get isBusyLoading => _isBusyLoading;

  set isBusyLoading(bool value) {
    _isBusyLoading = value;
    notifyListeners();
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    if (_hasError != value) {
      _hasError = value;
      notifyListeners();
    }
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

  Future<bool> fetchUserData() async {
    isBusyLoading = true;

    var result = await UserProfileRepository().getUserData();
    return result.fold((left) {
      /// if left
      _hasError = true;
      _isBusyLoading = false;

      notifyListeners();
      return false;
    }, (right) {
      /// if right

      _userData = right;
      _hasError = false;
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
}
