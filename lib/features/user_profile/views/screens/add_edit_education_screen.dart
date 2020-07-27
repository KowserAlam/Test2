import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notustohtml/notustohtml.dart';
import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/institution.dart';
import 'package:p7app/features/user_profile/models/major.dart';
import 'package:p7app/features/user_profile/repositories/degree_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/institution_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/major_subject_list_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/util/zefyr_helper.dart';
import 'package:p7app/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:p7app/main_app/views/widgets/custom_auto_complete_text_field.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_searchable_dropdown_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';

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
  TextEditingController majorTextController = TextEditingController();

  ZefyrController _descriptionZefyrController =
      ZefyrController(NotusDocument());
  final FocusNode _descriptionFocusNode = FocusNode();

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime _enrollDate;
  DateTime _graduationDate;
  String institutionNameErrorText;
  String enrollDateErrorText;
  String graduationDateErrorText;
  bool currentLyStudyingHere = false;
  Future<List<MajorSubject>> majorList;
  Future<List<Institution>> institutionList;
  String selectedDegree;
  MajorSubject selectedMajorSubject;
  Institution selectedInstitute;

  initState() {
    if (widget.educationModel != null) {
      selectedInstitute = widget.educationModel.institutionObj;
      _enrollDate = widget.educationModel.enrolledDate;
      _graduationDate = widget.educationModel.graduationDate;
      institutionNameController.text = selectedInstitute?.name ??
          widget.educationModel.institutionText ??
          "";
      gpaTextController.text = widget.educationModel.cgpa ?? "";
      selectedDegree = widget.educationModel.degree;
      selectedMajorSubject = widget.educationModel.major ?? null;
      majorTextController.text = widget.educationModel?.major?.name ??
          widget.educationModel?.majorText;
      _enrollDate = widget.educationModel.enrolledDate;
      _graduationDate = widget.educationModel.graduationDate;
      currentLyStudyingHere = widget.educationModel.graduationDate == null;
      _descriptionZefyrController = ZefyrController(
          ZeyfrHelper.htmlToNotusDocument(
              widget.educationModel?.description));
    }

    _initRepos();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  _initRepos() async {
    majorList = MajorSubListListRepository().getList();
    institutionList = InstitutionListRepository().getList();
  }

  bool validate() {
    bool isFormValid = _formKey.currentState.validate();
    bool isEnrollDateCorrect = _enrollDate != null;
    bool isGraduationDateCorrect() {
      if (currentLyStudyingHere) {
        _graduationDate = null;
        return true;
      } else {
        if (_graduationDate == null) {
          graduationDateErrorText =
              StringResources.blankGraduationDateWarningText;
          return false;
        } else {
          graduationDateErrorText = null;
          return true;
        }
      }
    }

    institutionNameErrorText = institutionNameController.text.isEmpty
        ? StringResources.thisFieldIsRequired
        : null;
    enrollDateErrorText =
        isEnrollDateCorrect ? null : StringResources.thisFieldIsRequired;
    setState(() {});

    return isFormValid &&
        isEnrollDateCorrect &&
        isGraduationDateCorrect() &&
        institutionNameErrorText == null;
  }

  void submitData(EduInfo education) {
    if (widget.educationModel != null) {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .updateEduInfo(education, index)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    } else {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .addEduInfo(education)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    }
  }

  MajorSubject getSelectedMajor() {
    if (selectedMajorSubject != null) {
      if (selectedMajorSubject.name == majorTextController.text) {
        return selectedMajorSubject;
      } else {
        return null;
      }
    }
    return null;
  }

  _handleSave() {
    var isSuccess = validate();

    if (isSuccess) {
      if (selectedDegree == null) {
        BotToast.showText(text: StringResources.noDegreeChosen);
      } else {
        var insId = selectedInstitute?.id;

        if (selectedInstitute != null) {
          if (selectedInstitute.name != institutionNameController.text) {
            insId = null;
          }
        }

        var education = EduInfo(
          educationId: widget.educationModel?.educationId,
          institutionId: insId,
          cgpa: gpaTextController.text,
          degree: selectedDegree,
          major: getSelectedMajor(),
          majorText: majorTextController.text,
          enrolledDate: _enrollDate,
          graduationDate: _graduationDate,
          description: ZeyfrHelper.notusDocumentToHTML(
              _descriptionZefyrController.document),
          institutionText: institutionNameController.text,
        );
        print("Degree: " + education.degree);

        if (currentLyStudyingHere) {
          submitData(education);
        } else {
          if (_enrollDate.isBefore(_graduationDate)) {
            submitData(education);
          } else {
            BotToast.showText(text: StringResources.graduationDateLogicText);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetween = SizedBox(
      height: 15,
    );

    var nameOfInstitution = CustomAutoCompleteTextField<Institution>(
      isRequired: true,
      labelText: StringResources.InstitutionText,
      hintText: StringResources.InstitutionHintText,
      validator: Validator().nullFieldValidate,
      onSuggestionSelected: (v) {
        institutionNameController.text = v.name;
        selectedInstitute = v;
      },
      controller: institutionNameController,
      itemBuilder: (context, m) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(m.name),
        );
      },
      suggestionsCallback: (q) async {
        return institutionList.then((value) {
          if (q.length <= 1) {
            return [];
          }
          return value.where((element) =>
              element.name.toLowerCase().contains(q.toLowerCase()));
        });
      },
    );

    var levelOfEducation = FutureBuilder<List<String>>(
      future: DegreeListRepository().getList(),
      builder: (context, AsyncSnapshot<List<String>> snap) {
        return CustomDropdownSearchFormField<String>(
          isRequired: true,
          showSearchBox: true,
          compareFn: (s1, s2) => s1.toLowerCase().contains(s2.toLowerCase()),
          validator: Validator().nullFieldValidate,
          labelText: StringResources.levelOfEducation,
          hintText: StringResources.tapToSelectText,
          selectedItem: selectedDegree,
          items: snap.data,
          onChanged: (v) {
            selectedDegree = v;
            print(selectedDegree);
            setState(() {});
          },
        );
      },
    );

    var major = CustomAutoCompleteTextField<MajorSubject>(
      labelText: StringResources.majorText,
      hintText: StringResources.majorHint,
      onSuggestionSelected: (v) {
        majorTextController.text = v.name;
        selectedMajorSubject = v;
      },
      controller: majorTextController,
      itemBuilder: (context, m) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(m.name),
        );
      },
      suggestionsCallback: (q) async {
        return majorList.then((value) {
          if (q.length <= 1) {
            return [];
          }
          return value.where((element) =>
              element.name.toLowerCase().contains(q.toLowerCase()));
        });
      },
    );

    var enrolledDate = CommonDatePickerFormField(
      isRequired: true,
      errorText: enrollDateErrorText,
      date: _enrollDate,
      label: StringResources.Enrolled,
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
    var graduationDate = CommonDatePickerFormField(
      errorText: graduationDateErrorText,
      date: _graduationDate,
      label: StringResources.graduationText,
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
      labelText: StringResources.gpaText,
      hintText: StringResources.gpaHintText,
      validator: Validator().numberFieldValidateOptional,
      keyboardType: TextInputType.number,
    );
    var description = CustomZefyrRichTextFormField(
      labelText: StringResources.descriptionText,
      focusNode: _descriptionFocusNode,
      controller: _descriptionZefyrController,
    );
    var ongoing = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(StringResources.currentlyStudyingHereText),
        Checkbox(
          onChanged: (bool value) {
            currentLyStudyingHere = value;
            if (!currentLyStudyingHere) {
              _graduationDate = null;
            }
            setState(() {});
          },
          value: currentLyStudyingHere,
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(StringResources.educationsText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringResources.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<UserProfileViewModel>(
            builder: (context, addEditEducationProvider, ch) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(
                        height: 10
                      ),
                      nameOfInstitution,
                      spaceBetween,

                      ///level of edu
                      levelOfEducation,

                      spaceBetween,

                      major,
                      spaceBetween,

                      /// gpaText
                      cgpa,
                      spaceBetween,
                      description,
                      spaceBetween,
                      enrolledDate,
                      spaceBetween,
                      ongoing,
//                    spaceBetween,
                      if (!currentLyStudyingHere) graduationDate,
                      spaceBetween,
                      spaceBetween,
                      spaceBetween,
                      spaceBetween,
                      spaceBetween,
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
