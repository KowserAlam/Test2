import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:p7app/features/user_profile/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExperienceProvider with ChangeNotifier{


  DateTime _joiningDate;
  DateTime _leavingDate;
 bool _currentLyWorkingHere = false;





 /// getters and setters

  bool get currentLyWorkingHere => _currentLyWorkingHere;

  set currentLyWorkingHere(bool value) {
    _currentLyWorkingHere = value;
    notifyListeners();
  }


  DateTime get joiningDate => _joiningDate??DateTime.now();

  set joiningDate(DateTime value) {
    _joiningDate = value;
    notifyListeners();
  }

  DateTime get leavingDate => _leavingDate??null;

  set leavingDate(DateTime value) {
    _leavingDate = value;
    notifyListeners();
  }

  ///events

onJoiningDateChangeEvent(DateTime value){ joiningDate = value; }
onLeavingDateChangeEvent(DateTime value){ leavingDate = value; }



addData(BuildContext context, experienceModel){
    /// add data in local state

  var userProvider = Provider.of<UserProvider>(context);

  var user = userProvider.userData;
  var expList = user.experienceList;
  expList.add(experienceModel);
  user.experienceList = expList;
  userProvider.userData = user;


  /// add data in remote server


}


  updateData(BuildContext context, Experience experienceModel,int index){
    /// update data in local state

    var userProvider = Provider.of<UserProvider>(context);

    var user = userProvider.userData;
    var expList = user.experienceList;
    expList.removeAt(index);
    expList.insert(index, experienceModel);
    user.experienceList = expList;
    userProvider.userData = user;


    /// update data in remote server


  }

 clearState(){

    _joiningDate = null;
    _leavingDate = null;
    _currentLyWorkingHere = false;

 }


}