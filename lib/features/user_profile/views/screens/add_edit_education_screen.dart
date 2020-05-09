import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/models/major.dart';
import 'package:p7app/features/user_profile/repositories/degree_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/institution_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/major_subject_list_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:rxdart/rxdart.dart';

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
  Institution selectedInstitute;

String selectedDegree;
MajorSubject selectedMajorSubject;

  var autoCompleteTextKey =
      GlobalKey<AutoCompleteTextFieldState<Institution>>();
  final _institutionListStreamController = BehaviorSubject<List<Institution>>();

  initState() {
    if (widget.educationModel != null) {
       selectedInstitute = widget.educationModel.institutionObj;
      _enrollDate = widget.educationModel.enrolledDate;
      _graduationDate = widget.educationModel.graduationDate;
      institutionNameController.text = selectedInstitute?.name ?? widget.educationModel.institutionText ?? "";
      gpaTextController.text = widget.educationModel.cgpa ?? "";
      selectedDegree = widget.educationModel.degree;
      selectedMajorSubject = widget.educationModel.major;
      _enrollDate = widget.educationModel.enrolledDate;
      _graduationDate = widget.educationModel.graduationDate;
    }

    _initRepos();
    super.initState();
  }

  dispose() {
    _institutionListStreamController.close();
    super.dispose();
  }

  _initRepos() async {
    dartZ.Either<AppError, List<Institution>> res =
        await InstitutionListRepository().getList();
    res.fold((l) {
      // error
      print(l);
    }, (List<Institution> r) {
      print(r);
      _institutionListStreamController.sink.add(r);
//      setState(() {
//        _institutionList = r;
//      });
    });
  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {
      var userProfileViewModel = Provider.of<UserProfileViewModel>(context,listen: false);

      var insId = selectedInstitute?.id;

      if(selectedInstitute != null){
        if(selectedInstitute.name != institutionNameController.text){
          insId = null;
        }
      }

      var education = EduInfo(
        educationId: widget.educationModel?.educationId,
        institutionId: insId,
        cgpa: gpaTextController.text,
        degree: selectedDegree,
        major: selectedMajorSubject,
        enrolledDate: _enrollDate,
        graduationDate: _graduationDate,
        institutionText: institutionNameController.text,

      );


      if(widget.educationModel == null){
        // add new
        userProfileViewModel.addEduInfo(education).then((value){
          if(value){
            Navigator.pop(context);
          }
        });
      }else{
        // update existing
        userProfileViewModel.updateEduInfo(education,index).then((value){
          if(value){
            Navigator.pop(context);
          }
        });


      }



    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(
      height: 15,
    );

    var nameOfInstitution = StreamBuilder<List<Institution>>(
        stream: _institutionListStreamController.stream,
        builder: (context, AsyncSnapshot<List<Institution>> snapshot) {
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("  " + StringUtils.nameOfOInstitutionText ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: CommonStyleTextField.boxShadow,
                  ),
                  child: AutoCompleteTextField<Institution>(
                    decoration: InputDecoration(
                      hintText: StringUtils.nameOfOInstitutionHintText,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      focusedBorder:
                          CommonStyleTextField.focusedBorder(context),
                    ),
                    controller: institutionNameController,
                    itemFilter: (Institution suggestion, String query) =>
                        suggestion.name
                            .toLowerCase()
                            .startsWith(query.toLowerCase()),
                    suggestions: snapshot.data,
                    itemSorter: (Institution a, Institution b) =>
                        a.name.compareTo(b.name),
                    key: autoCompleteTextKey,
                    itemBuilder:
                        (BuildContext context, Institution suggestion) {
                      return ListTile(
                        title: Text(suggestion.name ?? ""),
                      );
                    },
                    clearOnSubmit: false,
                    itemSubmitted: (Institution data) {
                      selectedInstitute = data;
                      institutionNameController.text = data.name;
                      setState(() {});
                    },
                  ),
                ),
              ],
            );

          return CustomTextFormField(
            validator: Validator().nullFieldValidate,
            controller: institutionNameController,
            labelText: StringUtils.nameOfOInstitutionText,
            hintText: StringUtils.nameOfOInstitutionHintText,
          );
        });


    var degree = FutureBuilder<dartZ.Either<AppError, List<String>>>(
      future: DegreeListRepository().getList(),
      builder:
          (context, AsyncSnapshot<dartZ.Either<AppError, List<String>>> snap) {
        if (snap.hasData) {
          return snap.data.fold((l) {
            return SizedBox();
          }, (r) {
            var items = r
                .map((e) => DropdownMenuItem<String>(
                      key: Key(e),
                      value: e,
                      child: Text(e ?? ""),
                    ))
                .toList();

            return CustomDropdownButtonFormField<String>(
              validator: Validator().nullFieldValidate,
              labelText: StringUtils.nameOfODegreeText,
              hint: Text(StringUtils.tapToSelectText),
              value: selectedDegree,
              items: items,
              onChanged: (v){
                selectedDegree = v;
                setState(() {

                });

              },
            );
          });
        }else{
          return Loader();
        }
      },
    );
    var major = FutureBuilder<dartZ.Either<AppError, List<MajorSubject>>>(
      future: MajorSubListListRepository().getList(),
      builder:
          (context, AsyncSnapshot<dartZ.Either<AppError, List<MajorSubject>>> snap) {
        if (snap.hasData) {
          return snap.data.fold((l) {
            return SizedBox();
          }, (r) {
            var items = r
                .map((e) => DropdownMenuItem<MajorSubject>(
                      key: Key(e.name),
                      value: e,
                      child: Text(e.name ?? ""),
                    ))
                .toList();

            return CustomDropdownButtonFormField<MajorSubject>(
              labelText: StringUtils.majorDateText,
              hint: Text(StringUtils.tapToSelectText),
              value: selectedMajorSubject,
              items: items,
              onChanged: (v){
                selectedMajorSubject = v;
                setState(() {

                });
              },
            );
          });
        }else{
          return Loader();
        }
      },
    );
    var enrolledDate = CommonDatePickerWidget(
      date: _enrollDate,
      label: StringUtils.enrollDate,
      onTapDateClear: () {
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
      onTapDateClear: () {
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
                    major,
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
}
