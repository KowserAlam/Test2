import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
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

class _AddEditEducationScreenState extends State<AddEditEducationScreen> {
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


  DateTime _enrollDate;
  DateTime _graduationDate;

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {
      var education = EduInfo(
        institution: institutionNameController.text,
        cgpa: gpaTextController.text,
        qualification: degreeTextController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(
      height: 15,
    );

    var nameOfInstitution = CustomTextFormField(
      validator: Validator().nullFieldValidate,
      textInputAction: TextInputAction.next,
      controller: institutionNameController,
      labelText: StringUtils.nameOfOInstitutionText,
      hintText: StringUtils.nameOfOInstitutionHintText,
    );
    var enrolledDate = CommonDatePickerWidget(
      date: _enrollDate,
      label: StringUtils.enrollDate,
      onTapDateClear: (){
        setState(() {
          _enrollDate = null;
        });
      },
      onDateTimeChanged: (v) {
        setState(() {
          _enrollDate = v;
        });
      },
    );
    var graduationDate = CommonDatePickerWidget(
      date: _graduationDate,
      label: StringUtils.graduationDate,
      onTapDateClear: (){
        setState(() {
          _graduationDate = null;
        });
      },
      onDateTimeChanged: (v) {
        setState(() {
          _graduationDate = v;
        });
      },
    );
    var degree = CustomTextFormField(
      validator: Validator().nullFieldValidate,

      textInputAction: TextInputAction.next,
      controller: degreeTextController,
      labelText: StringUtils.nameOfODegreeText,
      hintText: StringUtils.nameOfODegreeHintText,
    );
    var cgpa = CustomTextFormField(
      controller: gpaTextController,
      labelText: StringUtils.gpaText,
      hintText: StringUtils.gpaHintText,
    );

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
                    nameOfInstitution,
                    spaceBetween,

                    ///Degree
                    degree,
                    SizedBox(height: 15),

                    /// gpaText
                    cgpa,
                    enrolledDate,
                    spaceBetween,
                    graduationDate,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _showEnrollDatePicker(context) {
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
                          initialDateTime: _enrollDate ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v) {},
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

  _showGraduationDatePicker(context) {
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
                          initialDateTime: _enrollDate ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v) {},
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
