import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p7app/main_app/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class AddEditProfessionalSkill extends StatefulWidget {
  final SkillInfo skillInfo;
  final int index;
  final List<SkillInfo> previouslyAddedSkills;

  AddEditProfessionalSkill(
      {this.skillInfo, this.index, @required this.previouslyAddedSkills});

  @override
  _AddEditProfessionalSkillState createState() =>
      _AddEditProfessionalSkillState(this.skillInfo, this.index);
}

class _AddEditProfessionalSkillState extends State<AddEditProfessionalSkill> {
  final SkillInfo technicalSkill;
  final int index;
  bool loading;
  static double expertiseLevel = 0;
  bool topSkill = false;

//  static TextEditingController searchController = new TextEditingController();
  TextEditingController ratingController = new TextEditingController();

  _AddEditProfessionalSkillState(this.technicalSkill, this.index);

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Skill>> _skillList;
  static Skill _selectedSkill;

  initState() {
    loading = true;
    ratingController.text =
        widget.skillInfo == null ? "" : widget.skillInfo.rating.toString();
    if(widget.skillInfo!=null)topSkill=widget.skillInfo.isTopSkill;
//    searchController.text =
//        widget.skillInfo == null ? "" : widget.skillInfo.skill.name;
    _selectedSkill = widget.skillInfo == null ? null : widget.skillInfo.skill;
    _getSkillList();
    super.initState();
  }

  _getSkillList() async {
    _skillList = SkillListRepository()
        .getSkillList()
        .then((value) => value.fold((l) => [], (r) {
              if (this.mounted) setState(() {});
              return r;
            }));
  }

//  bool correctInput(String input) {
//    int x = 0;
//    for (int i = 0; i < searchList.length; i++) {
//      if (input.toLowerCase() == searchList[i].name.toLowerCase()) {
//        _selectedSkill = searchList[i];
//        x++;
//      }
//    }
//    if (x == 0) {
//      return false;
//    } else {
//      return true;
//    }
//    ;
//  }

  bool _isSkillAlreadyExist(String input) {
    int x = 0;
    for (int i = 0; i < widget.previouslyAddedSkills.length; i++) {
      if (input.toLowerCase() ==
          widget.previouslyAddedSkills[i].skill.name.toLowerCase()) {
        x++;
      }
    }
    if (x == 0) {
      return false;
    } else {
      return true;
    }
  }

  bool _isUpdating() => widget.skillInfo != null;

  String _skillValidator(Skill skill) {
    if (skill == null) {
      return StringResources.thisFieldIsRequired;
    }

    if (_isUpdating()) {
      bool isSkillChanged =
          _selectedSkill?.name != widget?.skillInfo?.skill?.name;
      if (isSkillChanged) {
        if (_isSkillAlreadyExist(_selectedSkill.name)) {
          return StringResources.youHaveAlreadyAddedThisSkillBeforeText;
        }
      } else {
        return null;
      }
    } else {
      if (_isSkillAlreadyExist(_selectedSkill.name)) {
        return StringResources.youHaveAlreadyAddedThisSkillBeforeText;
      }
    }

    return null;
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      if (widget.skillInfo == null) {
        var skillInfo = SkillInfo(
          profSkillId: widget.skillInfo?.profSkillId,
          rating: expertiseLevel,
          skill: _selectedSkill,
          isTopSkill: topSkill
        );

        /// adding new data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .addSkillData(skillInfo)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      } else {
        var updatedSKill = SkillInfo(
          profSkillId: widget.skillInfo?.profSkillId,
          rating: expertiseLevel,
          skill: _selectedSkill,
            isTopSkill: topSkill
        );

        /// updating existing data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .updateSkillData(updatedSKill, widget.index)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

//  List<Skill> filter(String pattern, List<Skill> a) {
//    searchList = a;
//    return a
//        .where(
//            (item) => item.name.toLowerCase().contains(pattern.toLowerCase()))
//        .toList();
////    a.removeWhere((item) => !item.name.toLowerCase().contains(pattern.toLowerCase()));
////    return a;
//  }

  @override
  Widget build(BuildContext context) {
    var skillName = FutureBuilder(
      future: _skillList,
      builder: (BuildContext context, AsyncSnapshot<List<Skill>> snapshot) {
        return CustomDropdownSearchFormField<Skill>(
          showSearchBox: true,
          dropdownKey: Key('skillAddField'),
          autoFocusSearchBox: true,
          isRequired: true,
          validator: _skillValidator,
          labelText: StringResources.skillNameText,
          items: snapshot.data,
          selectedItem: _selectedSkill,
          onChanged: (v) {
            _selectedSkill = v;
          },
        );
      },
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          StringResources.professionalSkillText,
          key: Key('professionalSkillAppbarTitle'),
        ),
        actions: <Widget>[
          EditScreenSaveButton(
            key: Key('skillSaveButton'),
            text: "Save",
            onPressed: _handleSave,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          _skillList = SkillListRepository()
              .getSkillList(forceGetFromServer: true)
              .then((value) => value.fold((l) => [], (r) {
                    if (this.mounted) setState(() {});
                    return r;
                  }));
          return _skillList;
        },
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
//                FutureBuilder<dartZ.Either<AppError, List<Skill>>>(
//                  future: SkillListRepository().getSkillList(),
//                  builder: (BuildContext context, AsyncSnapshot<dartZ.Either<AppError, List<Skill>>> snapshot){
//                    if(snapshot.hasData){
//                      return snapshot.data.fold((l){
//                        return SizedBox();
//                      }, (r){
//                        searchList = r;
//                        return Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text("  ${StringUtils.skillNameText}",
//                                style: TextStyle(fontWeight: FontWeight.bold)),
//                            SizedBox(
//                              height: 5,
//                            ),
//                            Container(
//                                padding: EdgeInsets.symmetric(horizontal: 8),
//                                decoration: BoxDecoration(
//                                  color: Theme.of(context).backgroundColor,
//                                  borderRadius: BorderRadius.circular(7),
//                                  boxShadow: [
//                                    BoxShadow(
//                                        color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
//                                    BoxShadow(
//                                        color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
//                                  ],
//                                ),
//                                child: AutoCompleteTextField<Skill>(
//                                  style: TextStyle(color: Colors.black, fontSize: 16),
//                                  decoration: InputDecoration(
//                                    hintText: StringUtils.searchSkillText,
//                                    border: InputBorder.none,
//                                  ),
//
//                                  itemBuilder: (context, skill) {
//                                    return Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Text(skill.name,
//                                        style: TextStyle(
//                                            fontSize: 16.0
//                                        ),),
//                                    );
//                                  },
//                                  key:  key,
//                                  clearOnSubmit: false,
//                                  controller: searchController,
//                                  itemFilter: (skill, query){
//                                    return skill.name.toLowerCase().startsWith(query.toLowerCase());
//                                  },
//                                  itemSorter: (a,b){
//                                    return a.name.compareTo(b.name);
//                                  },
//                                  itemSubmitted: (skill){
//                                    print(skill);
//                                    searchController.text = skill.name;
//                                    _selectedSkill = skill;
//                                  },
//                                  suggestions: r,
//                                )),
//                          ],
//                        );
//                      });
//                    };
//                    return Loader();
//                  },
//                ),
//                SizedBox(
//                  height: 30,
//                ),
                    skillName,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(StringResources.hasExpiryDateText),
                            Checkbox(
                              value: topSkill,
                              key: Key('certificationHasExpiryDate'),
                              onChanged: (bool newValue) {
                                if (newValue) {
                                  topSkill = newValue;
                                  setState(() {});
                                } else {
                                  topSkill = newValue;
                                  setState(() {});
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
//                    SizedBox(
//                      height: 30,
//                    ),
//                    CustomTextFormField(
//                      isRequired: true,
//                      textFieldKey: Key('skillExpertise'),
//                      keyboardType: TextInputType.number,
//                      controller: ratingController,
//                      validator: Validator().expertiseFieldValidate,
//                      labelText: "${StringResources.expertiseLevel} (0 - 10)",
//                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("${StringResources.expertiseLevel} (0 - 10)", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1,1),
                            color: Colors.grey[300],
                            spreadRadius: 1
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
//                          Text(StringResources.expertiseMessage[expertiseLevel.toInt()], textAlign: TextAlign.center,),
                          Text( expertiseLevel.toString(), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          SizedBox(height: 20,),
                          Slider(
                            value: expertiseLevel,
                            onChanged: (double v){
                              setState(() {
                                expertiseLevel = v;
                                print(expertiseLevel);
                              });
                            },
                            divisions: 10,
                            min: 0,
                            max: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
