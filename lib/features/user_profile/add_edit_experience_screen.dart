import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddNewExperienceScreen extends StatefulWidget {
  final ExperienceInfo experienceInfoModel;
  final int index;


  AddNewExperienceScreen({this.experienceInfoModel, this.index,});

  @override
  _AddNewExperienceScreenState createState() =>
      _AddNewExperienceScreenState(experienceInfoModel, index);
}

class _AddNewExperienceScreenState extends State<AddNewExperienceScreen>
    with AfterLayoutMixin {
  final ExperienceInfo experienceModel;
  final int index;
  bool currentLyWorkingHere = false;

  _AddNewExperienceScreenState(this.experienceModel, this.index);

  TextEditingController organizationNameController = TextEditingController();
  TextEditingController positionNameController = TextEditingController();
  TextEditingController roleNameController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {

  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

  }

  @override
  Widget build(BuildContext context) {
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
                      ///Name
                      CustomTextFormField(
                        validator: Validator().nullFieldValidate,
                        controller: organizationNameController,
                        hintText: StringUtils.nameOfOrganizationEg,
                        labelText: StringUtils.nameOfOrganizationText,
                      ),
                      SizedBox(height: 15),

                      /// Position

                      CustomTextFormField(
                        validator: Validator().nullFieldValidate,
                        controller: positionNameController,
                        labelText: StringUtils.positionText,
                        hintText: StringUtils.positionTextEg,
                      ),
                      SizedBox(height: 15),

                      /// Role

                      CustomTextFormField(
                        controller: roleNameController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        labelText: StringUtils.roleText,
                        hintText: StringUtils.roleTextEg,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                      ),

                      /// Joining Date
                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        children: <Widget>[
                          Text(
                            StringUtils.joiningDateText,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap: () {
                          _showJoinDatePicker(context);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                              BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),

                            ],),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "JD",
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          InkWell(
                            onTap: () {

                            },
                            child: Text(
                              StringUtils.currentlyWorkingHereText,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Checkbox(
                            value:false,
                            onChanged: (v) {

                            },
                          ),
                        ],
                      ),
                      /// Leaving Date

                      Text(
                        StringUtils.leavingDateText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color:
                                currentLyWorkingHere
                                    ? Colors.grey
                                    : null),
                      ),

                      SizedBox(
                        height: 8,
                      ),

                      InkWell(
                        onTap:  !currentLyWorkingHere
                            ? () {
                                _showLeavingDatePicker(context);
                              }
                            : null,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                              BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),

                            ],),
                          padding: EdgeInsets.all(8),
                          child: Text(
                          "leavingDate",
                            style: TextStyle(
                                color: currentLyWorkingHere
                                    ? Colors.grey
                                    : null),
                          ),
                        ),
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

  _showJoinDatePicker(context) {

    var initialDate = DateTime.now();

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v){},
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showLeavingDatePicker(context) {

    var initialDate = DateTime.now();

    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CupertinoTheme(
                        data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v){},
                        ),
                      ),
                    ),
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.done,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          );
        });
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
