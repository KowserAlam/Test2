import 'package:assessment_ishraak/features/user_profile/models/user_profile_models.dart';
import 'package:assessment_ishraak/features/user_profile/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class EducationProvider with ChangeNotifier {
  DateTime _passingYear = DateTime.now();
  bool _currentlyStudyingHere = false;

  bool get currentlyStudyingHere => _currentlyStudyingHere;

  set currentlyStudyingHere(bool value) {
    _currentlyStudyingHere = value;
    notifyListeners();
  }

  DateTime get passingYear => _passingYear;

  set passingYear(DateTime value) {
    _passingYear = value;
    notifyListeners();
  }

  ///events

  onStartingDateChangeEvent(DateTime value) {
    passingYear = value;
  }

  addData(BuildContext context, education) {
    /// add data in local state

    var userProvider = Provider.of<UserProvider>(context);

    var user = userProvider.userData;
    var eduList = user.educationModelList;
    eduList.add(education);
    user.educationModelList = eduList;
    userProvider.userData = user;

    /// add data in remote server
  }



  updateData(BuildContext context, Education educationModel, int index) {
    /// update data in local state
    var userProvider = Provider.of<UserProvider>(context);

    var user = userProvider.userData;
    var eduList = user.educationModelList;
    eduList.removeAt(index);
    eduList.insert(index, educationModel);
    user.educationModelList = eduList;
    userProvider.userData = user;

    /// update data in remote server
  }

  clearState() {
    _passingYear = null;
    _currentlyStudyingHere = false;
  }
}
