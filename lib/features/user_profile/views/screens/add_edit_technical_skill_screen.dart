import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:dartz/dartz.dart' as dartZ;

class AddEditTechnicalSkill extends StatefulWidget {
  final SkillInfo skillInfo;
  final int index;

  AddEditTechnicalSkill({this.skillInfo, this.index});

  @override
  _AddEditTechnicalSkillState createState() =>
      _AddEditTechnicalSkillState(this.skillInfo, this.index);
}

class _AddEditTechnicalSkillState extends State<AddEditTechnicalSkill> {
  final SkillInfo technicalSkill;
  final int index;
  bool loading;
  static List<Skill> searchList;
  static TextEditingController searchController = new TextEditingController();
  TextEditingController ratingController = new TextEditingController();


  _AddEditTechnicalSkillState(this.technicalSkill, this.index);

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<Skill>> skillList = [];
  static Skill _selectedSkill;
  static GlobalKey<AutoCompleteTextFieldState<Skill>> key = new GlobalKey();


  AutoCompleteTextField searchTextField = AutoCompleteTextField<Skill>(
    style: TextStyle(color: Colors.black, fontSize: 16),
    decoration: InputDecoration.collapsed(
      hintText: "Search your skills.",
    ),
    itemBuilder: (context, skill) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(skill.name,
              style: TextStyle(
                  fontSize: 16.0
              ),),
          ],
        ),
      );
    },
    key:  key,
    clearOnSubmit: false,
    controller: searchController,
    itemFilter: (skill, query){
      return skill.name.toLowerCase().startsWith(query.toLowerCase());
    },
    itemSorter: (a,b){
      return a.name.compareTo(b.name);
    },
    itemSubmitted: (skill){
      searchController.text = skill.name;
      _selectedSkill = skill;
    },
    suggestions: searchList,
  );


  initState() {
    loading = true;
    ratingController.text = widget.skillInfo == null ? "" : widget.skillInfo.rating.toString();
    _getSkillList();
    super.initState();
  }

  bool correctInput(String input){
    int x = 0;
    for(int i =0; i<searchList.length; i++){
      if(input == searchList[i].name) {
        x++;
      }
    }
    if(x==0){return false;}else {return true;};
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      if(correctInput(searchController.text)){
        var skillInfo = SkillInfo(
          profSkillId: widget.skillInfo?.profSkillId,
          rating: double.parse(ratingController.text),
          skill: _selectedSkill,
        );

        if (widget.skillInfo != null) {
          /// updating existing data

          Provider.of<UserProfileViewModel>(context, listen: false)
              .updateSkillData(skillInfo, widget.index)
              .then((value) {
            if (value) {
              Navigator.pop(context);
            }
          });
        } else {
          /// adding new data
          Provider.of<UserProfileViewModel>(context, listen: false)
              .addSkillData(skillInfo)
              .then((value) {
            if (value) {
              Navigator.pop(context);
            }
          });
        }
      }else{
        BotToast.showText(text: StringUtils.enterValidSkillText);
      }
    }
  }

  _getSkillList() async{
    await (SkillListRepository()
        .getSkillList()
        .then((dartZ.Either<AppError, List<Skill>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: StringUtils.unableToLoadSkillListText);
      }, (r) {
        // right;
        searchList = r;
        print(searchList.length);
        print(searchList);
        setState(() {});
      });
    })).then((a){loading = false;
    if(widget.skillInfo != null){
      searchController.text = widget.skillInfo.skill.name;
    }
    setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringUtils.professionalSkillText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: "Save",
            onPressed: _handleSave,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
              loading?SizedBox():Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                    BoxShadow(
                        color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
                  ],
                ),
                child: searchTextField,
              ),
                SizedBox(
                  height: 50,
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: ratingController,
                  validator: Validator().expertiseFieldValidate,
                  labelText: StringUtils.expertiseLevel,
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
