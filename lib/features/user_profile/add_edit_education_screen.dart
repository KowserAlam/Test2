import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:assessment_ishraak/features/user_profile/providers/education_provider.dart';
import 'package:assessment_ishraak/features/user_profile/models/user_profile_models.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/util/validator.dart';
import 'package:assessment_ishraak/main_app/widgets/button_with_primary_fill_color.dart';
import 'package:assessment_ishraak/main_app/widgets/edit_screen_save_button.dart';
import 'package:assessment_ishraak/main_app/widgets/rectangular_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddEditEducationScreen extends StatefulWidget {
  final Education educationModel;
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
  final Education educationModel;
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

    /// Initializing input fields when edit mode

    if (educationModel != null) {
      var addEditEducationProvider =
          Provider.of<EducationProvider>(context);
      institutionNameController.text = educationModel.nameOfInstitution;
      degreeTextController.text = educationModel.degree;
      gpaTextController.text = educationModel.gpa.toString();
      addEditEducationProvider.currentlyStudyingHere =
          educationModel.currentlyStudyingHere;
      addEditEducationProvider.passingYear = educationModel.passingYear;
    }
  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {
      var addEditEducationProvider =
          Provider.of<EducationProvider>(context);

      var education = Education(
          nameOfInstitution: institutionNameController.text,
          gpa: gpaTextController.text,
          passingYear: addEditEducationProvider.passingYear,
          degree: degreeTextController.text,
          currentlyStudyingHere:
              addEditEducationProvider.currentlyStudyingHere);

      if(education == null || index == null){
        education.id = Uuid().v1();
        addEditEducationProvider.addData(context, education);
      }else{
        education.id = educationModel.id;

        addEditEducationProvider.updateData(_scaffoldKey.currentContext, education, index);
      }

      Navigator.pop(context);
      addEditEducationProvider.clearState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        var addEditEducationProvider =
        Provider.of<EducationProvider>(context);
        addEditEducationProvider.clearState();
        return true;
      },
      child: Scaffold(
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
          child: Consumer<EducationProvider>(
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


                      TextFormField(
                        validator: Validator().nullFieldValidate,
                        focusNode: _institutionNameFocusNode,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (a) {
                          FocusScope.of(_scaffoldKey.currentContext)
                              .requestFocus(_degreeFocusNode);
                        },
                        style: Theme.of(context).textTheme.title,
                        controller: institutionNameController,
                        decoration: InputDecoration(
                            labelText: StringUtils.nameOfOInstitutionText,
                            hintText: StringUtils.nameOfOInstitutionHintText),
                      ),



                      ///Degree

                      TextFormField(
                        validator: Validator().nullFieldValidate,
                        focusNode: _degreeFocusNode,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (a) {
                          FocusScope.of(_scaffoldKey.currentContext)
                              .requestFocus(_percentageFocusNode);
                        },
                        style: Theme.of(context).textTheme.title,
                        controller: degreeTextController,
                        decoration: InputDecoration(
                            labelText: StringUtils.nameOfODegreeText,
                            hintText: StringUtils.nameOfODegreeHintText),
                      ),

                      SizedBox(height: 10),


                      /// gpaText

                      TextFormField(
                        controller: gpaTextController,
                        focusNode: _percentageFocusNode,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.title,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: StringUtils.gpaText,
                            hintText: StringUtils.gpaHintText),
                      ),

                      /// passingYear
                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        children: <Widget>[
                          Text(
                            StringUtils.passingYearText,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              addEditEducationProvider.currentlyStudyingHere =
                                  !addEditEducationProvider.currentlyStudyingHere;
                            },
                            child: Text(
                              StringUtils.currentlyStudyingHereText,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Checkbox(
                            value: addEditEducationProvider.currentlyStudyingHere,
                            onChanged: (v) {
                              addEditEducationProvider.currentlyStudyingHere = v;
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
                              border:
                                  Border.all(color: Colors.grey.withOpacity(.6))),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            addEditEducationProvider.passingYear != null
                                ? DateFormat()
                                    .add_yMMMMd()
                                    .format(addEditEducationProvider.passingYear)
                                    .toString()
                                : "",
                            style: Theme.of(context).textTheme.title,
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
    var provider = Provider.of<EducationProvider>(context);
    var initialDate = DateTime.now();
    if (provider.passingYear == null) {
      provider.onStartingDateChangeEvent(DateTime.now());
    } else {
      initialDate = provider.passingYear;
    }
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
                        data: CupertinoThemeData(),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: provider.onStartingDateChangeEvent,
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
