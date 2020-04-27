import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/repositories/institution_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
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

  var autoCompleteTextKey = GlobalKey<AutoCompleteTextFieldState<Institution>>();
  final _institutionListStreamController = BehaviorSubject<List<Institution>>();

  initState() {
    if (widget.educationModel != null) {
      _enrollDate = widget.educationModel.enrolledDate;
      _graduationDate = widget.educationModel.graduationDate;
      institutionNameController.text = widget.educationModel.institution ?? "";
      gpaTextController.text = widget.educationModel.cgpa ?? "";
      degreeTextController.text = widget.educationModel.qualification ?? "";
    }

    _initRepos();
    super.initState();
  }

  dispose(){
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
      var education = EduInfo(
        institution: selectedInstitute.id?.toString(),
        cgpa: gpaTextController.text,
        qualification: degreeTextController.text,
        enrolledDate: _enrollDate,
        graduationDate: _graduationDate,
      );

      UserProfileRepository().addUserEducation(education).then((value){
        value.fold((l){
          //error
        }, (r){
          // right
          Navigator.pop(context);
        });
      });

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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      focusedBorder: CommonStyleTextField.focusedBorder(context),
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
                    itemBuilder: (BuildContext context, Institution suggestion) {
                      return ListTile(
                        title: Text(suggestion.name ?? ""),
                      );
                    },
                    clearOnSubmit: false,
                    itemSubmitted: (Institution data) {
                      selectedInstitute = data;
                      institutionNameController.text = data.name;
                      setState(() {

                      });
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
    var degree = CustomTextFormField(
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
}
