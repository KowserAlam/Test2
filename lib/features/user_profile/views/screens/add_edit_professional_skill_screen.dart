import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
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
  static List<Skill> searchList=[];
  static TextEditingController searchController = new TextEditingController();
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
    searchController.text =
        widget.skillInfo == null ? "" : widget.skillInfo.skill.name;
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

  bool correctInput(String input) {
    int x = 0;
    for (int i = 0; i < searchList.length; i++) {
      if (input.toLowerCase() == searchList[i].name.toLowerCase()) {
        _selectedSkill = searchList[i];
        x++;
      }
    }
    if (x == 0) {
      return false;
    } else {
      return true;
    }
    ;
  }

  bool sameSkill(String input) {
    int x = 0;
    for (int i = 0; i < widget.previouslyAddedSkills.length; i++) {
      if (input.toLowerCase() ==
          widget.previouslyAddedSkills[i].skill.name.toLowerCase()) {
        x++;
      }
    }
    if (x == 0) {
      return true;
    } else {
      return false;
    }
    ;
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      print(searchController.text);
      if (correctInput(searchController.text)) {
        if (widget.skillInfo == null) {
          if (sameSkill(searchController.text)) {
            var skillInfo = SkillInfo(
              profSkillId: widget.skillInfo?.profSkillId,
              rating: double.parse(ratingController.text),
              skill: _selectedSkill,
            );
            print('Adding');

            /// adding new data
            Provider.of<UserProfileViewModel>(context, listen: false)
                .addSkillData(skillInfo)
                .then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          } else {
            BotToast.showText(text: StringResources.previouslyAddedSkillText);
          }
        } else {
          var updatedSKill = SkillInfo(
            profSkillId: widget.skillInfo?.profSkillId,
            rating: double.parse(ratingController.text),
            skill: _selectedSkill,
          );
          print('Updating');
          print(updatedSKill.skill.name);

          /// updating existing data
          if (updatedSKill.skill == widget.skillInfo.skill) {
            Provider.of<UserProfileViewModel>(context, listen: false)
                .updateSkillData(updatedSKill, widget.index)
                .then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          } else {
            if (sameSkill(searchController.text)) {
              Provider.of<UserProfileViewModel>(context, listen: false)
                  .updateSkillData(updatedSKill, widget.index)
                  .then((value) {
                if (value) {
                  Navigator.pop(context);
                }
              });
            } else {
              BotToast.showText(text: StringResources.previouslyAddedSkillText);
            }
          }
        }
      } else {
        BotToast.showText(text: StringResources.enterValidSkillText);
      }
    }
  }

  List<Skill> filter(String pattern, List<Skill> a) {
    searchList = a;
    return a
        .where(
            (item) => item.name.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
//    a.removeWhere((item) => !item.name.toLowerCase().contains(pattern.toLowerCase()));
//    return a;
  }

  @override
  Widget build(BuildContext context) {
    var skillName = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("  " + StringResources.skillNameText ?? "",
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyle.boxShadow,
          ),
          child: TypeAheadFormField<Skill>(
            key: Key('skillAddField'),
            textFieldConfiguration: TextFieldConfiguration(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: StringResources.searchSkillText,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            itemBuilder: (BuildContext context, Skill skill) {
              return Container(
                padding: EdgeInsets.all(8),
                child: Text(skill.name ?? ""),
              );
            },
            onSuggestionSelected: (Skill suggestion) {
              print(suggestion.name);
              searchController.text = suggestion.name;
              _selectedSkill = suggestion;
              setState(() {});
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            suggestionsCallback: (String pattern) async =>
                filter(pattern, await _skillList),
            loadingBuilder: (_) => Loader(),
            validator: (v) {
              return v.length < 2 ? StringResources.typeAtLeast2Letter : null;
            },
          ),
        ),
//        if (searchController != null)
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text(
//              "error",
//              style: TextStyle(color: Colors.red),
//            ),
//          ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringResources.professionalSkillText),
        actions: <Widget>[
          EditScreenSaveButton(
            key: Key('skillSaveButton'),
            text: "Save",
            onPressed: _handleSave,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
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
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      key: Key('skillExpertise'),
                      keyboardType: TextInputType.number,
                      controller: ratingController,
                      validator: Validator().expertiseFieldValidate,
                      labelText: "${StringResources.expertiseLevel} (0 - 10)",
                    ),
                    SizedBox(
                      height: 30,
                    )
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
