import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/main_app/util/json_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class UserProvider with ChangeNotifier {
  UserProfileModel _userData;
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

  UserProfileModel get userData => _userData ?? null;

  set userData(UserProfileModel value) {
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
      _hasError = false;
      _isBusyLoading = false;

      _userData = dummyUserData;
      _userData.displayName = right.displayName;
      _userData.email = right.email;
      _userData.profilePicUrl = right.profilePicUrl;
      _userData.displayName = right.displayName;
      _userData.id = right.id;
      _userData.mobileNumber = right.mobileNumber;
      _userData.designation = right.designation;
      _userData.city = right.city;
      _userData.about = right.about;

      notifyListeners();

      return true;
    });
  }

  Future<Map<String, String>> updateUserData(UserProfileModel user) async {
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
}

var dummyUserData = UserProfileModel(
    displayName: "Bill Gates",
    profilePicUrl:
        "https://pbs.twimg.com/profile_images/988775660163252226/XpgonN0X_400x400.jpg",
    city: "Dhaka, Bangladesh",
    designation: "American business magnate",
    about: "Co-chair of the Bill & Melinda Gates Foundation. "
        "Microsoft Co-founder. Voracious reader. Avid traveler. "
        "Active blogger.",
    email: "bill.gates@microsoft.com",
    mobileNumber: "+88010000000000",
    personalInfo: PersonalInfo(
      currentAddress:
          "House 76 (Level 4), Road 4, Block B, Niketan Gulshan 1, Dhaka 1212, Bangladesh",
      permanentAddress:
          "House 76 (Level 4), Road 4, Block B, Niketan Gulshan 1, Dhaka 1212, Bangladesh",
      fatherName: "Father Name",
      motherName: "Mother Name",
      religion: "Religion",
      dateOfBirth: DateTime.now(),
      languages: ["Ennglish", "Bangla", "Hindi"],
      gender: "Male",
      nationality: "Bangladeshi",
      maritalStatus: "Single",
    ),
    experienceList: [
      Experience(
          id: Uuid().v1(),
          organizationName: "Ishraak Solutions",
          position: "Software Engineer",
          joiningDate: DateTime.now().subtract(
            Duration(days: 360 * 50),
          ),
          role:
              "William Henry Gates III is an American business magnate, investor, author, philanthropist, and humanitarian. He is best known as the principal founder of Microsoft Corporatio",
          currentlyWorkHere: false,
          leavingDate: DateTime.now().subtract(
            Duration(days: 360 * 30),
          )),
      Experience(
          id: Uuid().v1(),
          organizationName: "Microsoft",
          position: "CEO",
          joiningDate: DateTime.now().subtract(
            Duration(days: 360 * 30),
          ),
          currentlyWorkHere: true,
          role:
              "William Henry Gates III is an American business magnate, investor, author, philanthropist, and humanitarian. He is best known as the principal founder of Microsoft Corporatio"),
    ],
    educationModelList: [
      Education(
          id: Uuid().v1(),
          degree: "Bachelor of Science",
          nameOfInstitution: "Howard University",
          passingYear: DateTime.now().add(Duration(days: 356 * 80)),
          currentlyStudyingHere: false,
          gpa: "4.2"),
    ],
    technicalSkillList: [
      TechnicalSkill(
          id: Uuid().v1(), level: 4.5, skillName: "Django", isVerified: true),
      TechnicalSkill(
          id: Uuid().v1(), level: 4.5, skillName: "Python", isVerified: false),
    ]);
