import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/button_with_primary_fill_color.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:p7app/main_app/widgets/rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddEditEducationScreen extends StatefulWidget {
  final EduInfo educationModel;
  final int index;

  AddEditEducationScreen({
    this.educationModel,
    this.index,
  });

  @override
  _AddEditEducationScreenState createState() =>
      _AddEditEducationScreenState(educationModel, index);
}

class _AddEditEducationScreenState extends State<AddEditEducationScreen>
    with AfterLayoutMixin {
  final EduInfo educationModel;
  final int index;

  _AddEditEducationScreenState(
    this.educationModel,
    this.index,
  );

  TextEditingController institutionNameController = TextEditingController();
  TextEditingController gpaTextController = TextEditingController();
  TextEditingController degreeTextController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _institutionNameFocusNode = FocusNode();
  final FocusNode _degreeFocusNode = FocusNode();
  final FocusNode _percentageFocusNode = FocusNode();

  @override
  void afterFirstLayout(BuildContext context) {

  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {


      var education = EduInfo(
          institution: institutionNameController.text,
          cgpa: gpaTextController.text,
          qualification: degreeTextController.text,);
      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(StringUtils.educationsText),
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
          builder: (context, addEditEducationProvider, ch) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),

                    /// nameOfOInstitutionText

                    CustomTextFormField(
                      validator: Validator().nullFieldValidate,
                      focusNode: _institutionNameFocusNode,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (a) {
                        FocusScope.of(_scaffoldKey.currentContext)
                            .requestFocus(_degreeFocusNode);
                      },
                      controller: institutionNameController,
                      labelText: StringUtils.nameOfOInstitutionText,
                      hintText: StringUtils.nameOfOInstitutionHintText,
                    ),
                    SizedBox(height: 15),
                    ///Degree

                    CustomTextFormField(
                      validator: Validator().nullFieldValidate,
                      focusNode: _degreeFocusNode,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (a) {
                        FocusScope.of(_scaffoldKey.currentContext)
                            .requestFocus(_percentageFocusNode);
                      },
                      controller: degreeTextController,
                      labelText: StringUtils.nameOfODegreeText,
                      hintText: StringUtils.nameOfODegreeHintText,
                    ),

                    SizedBox(height: 15),

                    /// gpaText

                    CustomTextFormField(
                      controller: gpaTextController,
                      focusNode: _percentageFocusNode,
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      labelText: StringUtils.gpaText,
                      hintText: StringUtils.gpaHintText,
                    ),

                    /// passingYear
                    SizedBox(
                      height: 16
                    ),

                    Row(
                      children: <Widget>[
                        Text(
                          StringUtils.passingYearText,
                          textAlign: TextAlign.left,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {

                          },
                          child: Text(
                            StringUtils.currentlyStudyingHereText,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Checkbox(
                          value:
                              false,
                          onChanged: (v) {

                          },
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
                         "",
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
                        data: CupertinoThemeData(
                            brightness: Theme.of(context).brightness),
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
