import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/models/nationality.dart';
import 'package:p7app/features/user_profile/models/religion.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:p7app/features/user_profile/models/user_personal_info.dart';
import 'package:p7app/features/user_profile/repositories/gender_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/nationality_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/religion_list_repository.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/common_button.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:p7app/method_extension.dart';

class EditPersonalInfoScreen extends StatefulWidget {
  final UserModel userModel;

  EditPersonalInfoScreen({@required this.userModel});

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingController
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _permanentAddressController = TextEditingController();
  final _bloodGroupController = TextEditingController();

//  final _nationalityController = TextEditingController();
//  final _religionController = TextEditingController();

  //FocusNode
  final _fatherNameFocusNode = FocusNode();
  final _motherNameFocusNode = FocusNode();
  final _nationalityFocusNode = FocusNode();
  final _currentAddressFocusNode = FocusNode();
  final _permanentAddressFocusNode = FocusNode();
  final _religionFocusNode = FocusNode();

  //Date
  DateTime _chosenBirthDate;

  //Nationality
  List<DropdownMenuItem<Nationality>> _nationalityList = [];
  Nationality _selectedNationalityDropDownItem;

  //Religion
  List<DropdownMenuItem<Religion>> _religionList = [];
  Religion _selectedReligionDropDownItem;

  //Gender
  List<DropdownMenuItem<String>> _genderList = [
//    new DropdownMenuItem(value: 'Male',child: Text('Male'),),
//    new DropdownMenuItem(value: 'Female',child: Text('Female'),),
//    new DropdownMenuItem(value: null,child: Text('Prefer not to share'),)
  ];

  //Gender
  List<String> _bloodGroupList = [
    "",
    "O+",
    "O-",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
  ];

  String _selectedBloodGroup;

  String _selectedGenderDropDownItem;

  @override
  void initState() {
    // TODO: implement initState
    var personalInfo = widget.userModel.personalInfo;
    _fatherNameController.text = personalInfo.fatherName ?? "";
    _motherNameController.text = personalInfo.motherName ?? "";
    _currentAddressController.text = personalInfo.address ?? "";
    _permanentAddressController.text = personalInfo.permanentAddress ?? "";
    _selectedReligionDropDownItem = personalInfo.religionObj;
    _selectedNationalityDropDownItem = personalInfo.nationalityObj;
    _selectedGenderDropDownItem = personalInfo.gender;
    _chosenBirthDate = personalInfo.dateOfBirth;
    _selectedBloodGroup = personalInfo.bloodGroup;

    NationalityListRepository()
        .getNationalityList()
        .then((dartZ.Either<AppError, List<Nationality>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: StringResources.unableToFetchList);
      }, (r) {
        // right
        _nationalityList = r
            .map((e) => DropdownMenuItem(
                  key: Key(e.name),
                  value: e,
                  child: Text(e.name ?? ""),
                ))
            .toList();
        setState(() {});
      });
    });

    ReligionListRepository()
        .getReligionList()
        .then((dartZ.Either<AppError, List<Religion>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: StringResources.unableToFetchList);
      }, (r) {
        // right
        _religionList = r
            .map((e) => DropdownMenuItem(
                  key: Key(e.name),
                  value: e,
                  child: Text(e.name ?? ""),
                ))
            .toList();
        setState(() {});
      });
    });

    GenderListRepository()
        .getGenderList()
        .then((dartZ.Either<AppError, List<String>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: StringResources.unableToFetchList);
      }, (r) {
        // right
        _genderList = r
            .map((e) => DropdownMenuItem(
                  key: Key(e),
                  value: e,
                  child: Text(e ?? ""),
                ))
            .toList();
        setState(() {});
      });
    });

    super.initState();
  }

  _handleSave() async {
    var isValid = _formKey.currentState.validate();

    if (isValid) {
      var userViewModel =
          Provider.of<UserProfileViewModel>(context, listen: false);
      var userData = userViewModel.userData;
      UserPersonalInfo personalInfo = userViewModel.userData.personalInfo;

      var data = {
        "father_name": _fatherNameController.text,
        "mother_name": _motherNameController.text,
        "permanent_address": _permanentAddressController.text,
        "nationality": _selectedNationalityDropDownItem?.id,
        "religion": _selectedReligionDropDownItem?.id,
        "address": _currentAddressController.text,
        "gender": _selectedGenderDropDownItem,
        "blood_group": _selectedBloodGroup,
      };

      if (_chosenBirthDate != null) {
        print(DateFormatUtil.dateFormatYYYMMDD(_chosenBirthDate));
        data.addAll({
          "date_of_birth": DateFormatUtil.dateFormatYYYMMDD(_chosenBirthDate)
        });
      }

      dartZ.Either<AppError, UserPersonalInfo> res =
          await UserProfileRepository().updateUserBasicInfo(data);
      res.fold((l) {
        // left
        print(l);
      }, (UserPersonalInfo r) {
        //right
        userData.personalInfo = r;
        print(r.fullName);
        print(userData.personalInfo.fullName);
        userViewModel.userData = userData;
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle
    TextStyle titleFont = TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
    var spaceBetweenFields = SizedBox(
      height: 15,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.personalInfoText),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringResources.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Date of Birth
                  CommonDatePickerWidget(
                    label: StringResources.dateOfBirthText,
                    date: _chosenBirthDate,
                    onDateTimeChanged: (v) {
                      setState(() {
                        _chosenBirthDate = v;
                      });
                    },
//                    onTapDateClear: (){
//                      setState(() {
//                        _chosenBirthDate = null;
//                      });
//                    },
                  ),
                  spaceBetweenFields,
                  //Gender
                  CustomDropdownButtonFormField<String>(
                    labelText: StringResources.genderText,
                    hint: Text(StringResources.tapToSelectText),
                    value: _selectedGenderDropDownItem,
                    onChanged: (value) {
                      _selectedGenderDropDownItem = value;
                      setState(() {});
                    },
                    items: _genderList,
                  ),
                  spaceBetweenFields,
                  //Father's Name
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    //focusNode: _fatherNameFocusNode,
//                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_motherNameFocusNode);
                    },
                    controller: _fatherNameController,
                    labelText: StringResources.fatherNameText,
                    hintText: StringResources.fatherNameText,
                  ),
                  spaceBetweenFields,
                  //Mother's Name
                  CustomTextFormField(
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_currentAddressFocusNode);
                    },
                    controller: _motherNameController,
                    labelText: StringResources.motherNameText,
                    hintText: StringResources.motherNameText,
                  ),
                  spaceBetweenFields,
                  //Current Address
                  CustomTextFormField(
                    maxLength: 255,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 8,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_permanentAddressFocusNode);
                    },
                    controller: _currentAddressController,
                    labelText: StringResources.currentAddressText,
                    hintText: StringResources.currentAddressText,
                  ),
                  spaceBetweenFields,
                  //Permanent Address
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    //focusNode: _permanentAddressFocusNode,
                    maxLength: 255,
                    minLines: 3,
                    maxLines: 8,
//                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_nationalityFocusNode);
                    },
                    controller: _permanentAddressController,
                    labelText: StringResources.permanentAddressText,
                    hintText: StringResources.permanentAddressText,
                  ),
                  spaceBetweenFields,
                  //Nationality
                  CustomDropdownButtonFormField<Nationality>(
                    labelText: StringResources.nationalityText,
                    hint: Text(StringResources.tapToSelectText),
                    value: _selectedNationalityDropDownItem,
                    onChanged: (value) {
                      _selectedNationalityDropDownItem = value;
                      setState(() {});
                    },
                    items: _nationalityList,
                  ),
                  spaceBetweenFields,
                  //Religion
                  CustomDropdownButtonFormField<Religion>(
                    labelText: StringResources.religionText,
                    hint: Text(StringResources.tapToSelectText),
                    value: _selectedReligionDropDownItem,
                    onChanged: (value) {
                      _selectedReligionDropDownItem = value;
                      setState(() {});
                    },
                    items: _religionList,
                  ),
                  spaceBetweenFields,
                  //Mother's Name
                  CustomDropdownButtonFormField<String>(
                    labelText: StringResources.bloodGroupText,
                    hint: Text(StringResources.tapToSelectText),
                    value: _selectedBloodGroup,
                    onChanged: (value) {
                      _selectedBloodGroup = value;
                      setState(() {});
                    },
                    items: _bloodGroupList
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e.isEmptyOrNull?" - - - -":e),
                              value: e,
                              key: Key(e),
                            ))
                        .toList(),
                  ),
                  spaceBetweenFields
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
