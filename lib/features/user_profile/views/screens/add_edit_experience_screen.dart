import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/repositories/organization_list_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dartZ;



class AddNewExperienceScreen extends StatefulWidget {
  final ExperienceInfo experienceInfoModel;
  final int index;
  final List<ExperienceInfo> previouslyAddedExp;


  AddNewExperienceScreen({this.experienceInfoModel, this.index,this.previouslyAddedExp});

  @override
  _AddNewExperienceScreenState createState() =>
      _AddNewExperienceScreenState(experienceInfoModel, index);
}

class _AddNewExperienceScreenState extends State<AddNewExperienceScreen>
    with AfterLayoutMixin {
  final ExperienceInfo experienceModel;
  final int index;
  bool currentLyWorkingHere = false;
  DateTime _joiningDate, _leavingDate;
  static GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String _selectedCompanyId;
  int _experienceId;

  _AddNewExperienceScreenState(this.experienceModel, this.index);

  TextEditingController organizationNameController = TextEditingController();
  TextEditingController positionNameController = TextEditingController();


  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.experienceInfoModel != null){
      organizationNameController.text = widget.experienceInfoModel.organizationName??"";
      positionNameController.text = widget.experienceInfoModel.designation??"";
      _joiningDate = widget.experienceInfoModel.startDate;
      _leavingDate = widget.experienceInfoModel.endDate;
      _selectedCompanyId = widget.experienceInfoModel.organizationId??null;
      _experienceId = widget.experienceInfoModel.experienceId??null;
    }
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {

  }

  bool sameExperience(String input){
    int x = 0;
    for(int i =0; i<widget.previouslyAddedExp.length; i++){
      if(input == widget.previouslyAddedExp[i].organizationName) {
        x++;
      }
    }
    if(x==0){return true;}else {return false;};
  }

  void updateExp(ExperienceInfo experienceInfo){
    print('Updating');
    Provider.of<UserProfileViewModel>(context, listen: false)
        .updateExperienceData(experienceInfo, widget.index)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  void addExp(ExperienceInfo experienceInfo){
    /// adding new data
    print('Adding');
    Provider.of<UserProfileViewModel>(context, listen: false)
        .addExperienceData(experienceInfo)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();
    if(isSuccess){
      //Form validated
      if(_selectedCompanyId != null){
        if(organizationNameController.text != _selectedCompanyId){
          _selectedCompanyId = null;
          setState(() {

          });
        }
      }
      var experienceInfo = ExperienceInfo(
          experienceId: widget.experienceInfoModel?.experienceId,
          organizationName: organizationNameController.text,
          designation: positionNameController.text,
          organizationId: _selectedCompanyId,
          startDate: _joiningDate,
          endDate: _leavingDate
      );
      if(_joiningDate != null && _leavingDate != null){
        if(_joiningDate.isBefore(_leavingDate)){
          if(widget.experienceInfoModel != null){
            print('1');
            if(widget.experienceInfoModel.organizationName != organizationNameController.text){
              print('1.1');
              if(sameExperience(organizationNameController.text)){
                print('1.2');
                updateExp(experienceInfo);
              }else{print('1.3');BotToast.showText(text: StringUtils.sameExperience);}
            }else{
              print('1.4');
              updateExp(experienceInfo);
            }
          }else{
            print('1.5');
            if(sameExperience(organizationNameController.text)){
              addExp(experienceInfo);
            }else{print('1.6');BotToast.showText(text: StringUtils.sameExperience);}
          }
        }else{
          print('1.5');BotToast.showText(text: StringUtils.joiningLeavingDateLogic);
        }
    }else{
        if(widget.experienceInfoModel != null){
          print('2');
          if(widget.experienceInfoModel.organizationName != organizationNameController.text){
            print('2.1');
            if(sameExperience(organizationNameController.text)){
              print('2.2');
              updateExp(experienceInfo);
            }else{print('2.3');BotToast.showText(text: StringUtils.sameExperience);}
          }else{
            print('2.4');
            updateExp(experienceInfo);
          }
        }else{
          if(sameExperience(organizationNameController.text)){
            print('2.5');
            addExp(experienceInfo);
          }else{print('2.6');BotToast.showText(text: StringUtils.sameExperience);}
        }
      }
  }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenSections = SizedBox(height: 20,);
    return WillPopScope(
      onWillPop: () async {

        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(StringUtils.experienceText),
          actions: <Widget>[
            EditScreenSaveButton(
              text: StringUtils.saveText,
              onPressed: _handleSave,
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<UserProfileViewModel>(
            builder: (context, addEditExperienceProvider, ch) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///Organization Name
                      FutureBuilder<dartZ.Either<AppError, List<String>>>(
                          future: CompanyListRepository().getCompanyList(),
                          builder: (BuildContext context, AsyncSnapshot<dartZ.Either<AppError, List<String>>> snapshot){
                          if(snapshot.hasData){
                            return snapshot.data.fold((l){
                              print("no data");
                              return SizedBox();
                            }, (r){
                                return Container(
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
                                    child: AutoCompleteTextField<String>(
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                      decoration: InputDecoration.collapsed(
                                        hintText: StringUtils.searchSkillText,
                                      ),
                                      itemBuilder: (context, orgName) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(orgName,
                                                style: TextStyle(
                                                    fontSize: 16.0
                                                ),),
                                            ],
                                          ),
                                        );
                                      },
                                      key:  key,
                                      clearOnSubmit: false,
                                      controller: organizationNameController,
                                      itemFilter: (orgName, query){
                                        return orgName.toLowerCase().startsWith(query.toLowerCase());
                                      },
                                      itemSorter: (a,b){
                                        return a.compareTo(b);
                                      },
                                      itemSubmitted: (orgName){
                                        organizationNameController.text = orgName;
                                        _selectedCompanyId = orgName;
                                        print(_selectedCompanyId);
                                      },
                                      suggestions: r,
                                    ));
                              });
                            };
                            return Container(
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
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontSize: 16),
                                decoration: InputDecoration.collapsed(
                                  hintText: StringUtils.searchSkillText,
                                ),
                                controller: organizationNameController,
                              ),
                            );
                          },
                    ),
                      spaceBetweenSections,

                      /// Position
                      CustomTextFormField(
                        //validator: Validator().nullFieldValidate,
                        controller: positionNameController,
                        labelText: StringUtils.positionText,
                        hintText: StringUtils.positionTextEg,
                      ),
                      spaceBetweenSections,

                      /// Joining Date
                      CommonDatePickerWidget(
                        label: StringUtils.joiningDateText,
                        date: _joiningDate,
                        onDateTimeChanged: (v){
                          setState(() {
                            _joiningDate = v;
                          });
                        },
                        onTapDateClear: (){
                          setState(() {
                            _joiningDate = null;
                          });
                        },
                      ),

                      /// Leaving Date
                      CommonDatePickerWidget(
                        label: StringUtils.leavingDateText,
                        date: _leavingDate,
                        onDateTimeChanged: (v){
                          setState(() {
                            _leavingDate = v;
                            print(_leavingDate);
                          });
                        },
                        onTapDateClear: (){
                          setState(() {
                            _leavingDate = null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}

class ErrorWidget extends StatelessWidget {
  final String errorText;
  final Widget child;

  ErrorWidget({
    this.errorText,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (errorText == null) {
      return child;
    } else {
      return Container(
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).errorColor, width: 2)),
              child: child,
            )
          ],
        ),
      );
    }
  }
}
