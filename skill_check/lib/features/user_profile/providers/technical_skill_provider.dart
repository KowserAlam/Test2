
import 'package:skill_check/features/user_profile/models/user_profile_models.dart';
import 'package:skill_check/features/user_profile/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TechnicalSkillProvider with ChangeNotifier{


  double _skillLevel=0.0;

  double get skillLevel => _skillLevel?? null;

  set skillLevel(double value) {
    _skillLevel = value;
    notifyListeners();
  }


  addData(BuildContext context, education) {
    /// add data in local state

    var userProvider = Provider.of<UserProvider>(context);

    var user = userProvider.userData;
    var list = user.technicalSkillList;
    list.add(education);
    user.technicalSkillList = list;
    userProvider.userData = user;

    /// add data in remote server
  }



  updateData(BuildContext context, TechnicalSkill technicalSkill, int index) {
    /// update data in local state
    var userProvider = Provider.of<UserProvider>(context);

    var user = userProvider.userData;
    var list = user.technicalSkillList;
    list.removeAt(index);
    list.insert(index, technicalSkill);
    user.technicalSkillList = list;
    userProvider.userData = user;

    /// update data in remote server
  }

  clearState() {
    _skillLevel = null;
    skillLevel = null;
  }


}