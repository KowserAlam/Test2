import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p7app/features/company/models/company.dart';
import 'package:p7app/features/company/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class AddNewExperienceScreen extends StatefulWidget {
  final ExperienceInfo experienceInfoModel;
  final int index;
  final List<ExperienceInfo> previouslyAddedExp;

  AddNewExperienceScreen(
      {this.experienceInfoModel, this.index, this.previouslyAddedExp});

  @override
  _AddNewExperienceScreenState createState() =>
      _AddNewExperienceScreenState(experienceInfoModel, index);
}

class _AddNewExperienceScreenState extends State<AddNewExperienceScreen> {
  final ExperienceInfo experienceModel;
  final int index;
  bool currentLyWorkingHere = false;
  DateTime _joiningDate, _leavingDate;
  Company selectedCompany;
  String _selectedCompanyId;
  String _experienceId;
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController positionNameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Company> companySuggestion = [];
  String _companyNameErrorText;
  String _joiningDateErrorText;
  String _leavingDateErrorText;

  ZefyrController _descriptionZefyrController =
      ZefyrController(NotusDocument());
  final FocusNode _descriptionFocusNode = FocusNode();

  _AddNewExperienceScreenState(this.experienceModel, this.index);

  @override
  void initState() {
    if (widget.experienceInfoModel != null) {
      _companyNameController.text =
          widget.experienceInfoModel.companyName ?? "";
      positionNameController.text =
          widget.experienceInfoModel.designation ?? "";
      _joiningDate = widget.experienceInfoModel.startDate;
      _leavingDate = widget.experienceInfoModel.endDate;
      _selectedCompanyId = widget.experienceInfoModel.companyName;
      _experienceId = widget.experienceInfoModel.experienceId ?? null;
      currentLyWorkingHere = _leavingDate == null;
      _descriptionZefyrController = ZefyrController(
        ZeyfrHelper.htmlToNotusDocument(
            widget.experienceInfoModel?.description ?? " "),
      );
    }
    super.initState();
  }

  bool sameExperience(String input) {
    int x = 0;
    for (int i = 0; i < widget.previouslyAddedExp.length; i++) {
      if (input == widget.previouslyAddedExp[i].companyName) {
        x++;
      }
    }
    if (x == 0) {
      return true;
    } else {
      return false;
    }
    ;
  }

  void updateExp(ExperienceInfo experienceInfo) {
    print('Updating');
    Provider.of<UserProfileViewModel>(context, listen: false)
        .updateExperienceData(experienceInfo, widget.index)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  void addExp(ExperienceInfo experienceInfo) {
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

  bool validate() {
    bool isNotEmpty = _companyNameController.text.isNotEmpty;
    _companyNameErrorText =
        !isNotEmpty ? StringResources.thisFieldIsRequired : null;
    bool dateCheck() {
      if (_joiningDate != null) {
        _joiningDateErrorText = null;
        if (currentLyWorkingHere) {
          _leavingDateErrorText = null;
          _leavingDate = null;
          return true;
        } else {
          if (_leavingDate != null) {
            _leavingDateErrorText = null;
            if (_joiningDate.isBefore(_leavingDate)) {
              return true;
            } else {
              BotToast.showText(text: StringResources.joiningLeavingDateLogic);
              return false;
            }
          } else {
            _leavingDateErrorText = StringResources.blankLeavingDateErrorText;
            return false;
          }
        }
      } else {
        _joiningDateErrorText = StringResources.blankJoiningDateErrorText;
        return false;
      }
    }

    setState(() {});
    return isNotEmpty && dateCheck();
  }

  _handleSave() {
    var isSuccess = validate();
    if (isSuccess) {
//      Form validated
      if (_selectedCompanyId != null) {
        if (_companyNameController.text != _selectedCompanyId) {
          _selectedCompanyId = null;
//          setState(() {});
        }
      }
      var experienceInfo = ExperienceInfo(
        experienceId: widget.experienceInfoModel?.experienceId,
        companyName: _companyNameController.text,
        designation: positionNameController.text,
        companyId: selectedCompany?.name ?? _companyNameController.text,
        startDate: _joiningDate,
        endDate: _leavingDate,
        description: ZeyfrHelper.notusDocumentToHTML(
            _descriptionZefyrController.document),
      );

      if (widget.experienceInfoModel == null) {
        addExp(experienceInfo);
      } else {
        updateExp(experienceInfo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenSections = SizedBox(
      height: 20,
    );

    var name = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text("  " + StringResources.company ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              " *",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(7),
            boxShadow: CommonStyleTextField.boxShadow,
          ),
          child: TypeAheadFormField<Company>(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _companyNameController,
                decoration: InputDecoration(
                  hintText: StringResources.currentCompanyHint,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            itemBuilder: (BuildContext context, Company suggestion) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      height: 20,
                      width: 20,
                      imageUrl: suggestion.profilePicture ?? "",
                      placeholder: (context, _) => Image.asset(
                        kCompanyImagePlaceholder,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(suggestion.name ?? ""),
                  ],
                ),
              );
            },
            onSuggestionSelected: (Company suggestion) {
              print(suggestion.name);
              _companyNameController.text = suggestion.name;
              selectedCompany = suggestion;
              setState(() {});
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            suggestionsCallback: (String pattern) {
              if (pattern.length > 2)
                return CompanyListRepository()
                    .getList(query: pattern)
                    .then((value) => value.fold((l) => [], (r) => r.companies));
              else
                return [];
            },
            validator: (v) {
              return v.length < 3 ? StringResources.typeAtLeast3Letter : null;
            },
            noItemsFoundBuilder: (context) {
              return SizedBox();
            },
          ),
        ),
        if (_companyNameErrorText != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _companyNameErrorText,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(StringResources.workExperienceText),
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
              builder: (context, addEditExperienceProvider, ch) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        spaceBetweenSections,
                        name,
//                      nameOfCompany,
                        spaceBetweenSections,

                        /// designation
                        CustomTextFormField(
                          //validator: Validator().nullFieldValidate,
                          controller: positionNameController,
                          labelText: StringResources.designationText,
                          hintText: StringResources.designationHintText,
                          autofocus: false,
                        ),
                        spaceBetweenSections,
                        CustomZefyrRichTextFormField(
                          labelText: StringResources.descriptionText,
                          focusNode: _descriptionFocusNode,
                          controller: _descriptionZefyrController,
                        ),
                        spaceBetweenSections,

                        /// Joining Date
                        CommonDatePickerFormField(
                          isRequired: true,
                          errorText: _joiningDateErrorText,
                          label: StringResources.joiningDateText,
                          date: _joiningDate,
                          onDateTimeChanged: (v) {
                            setState(() {
                              _joiningDate = v;
                            });
                          },
                          onTapDateClear: () {
                            setState(() {
                              _joiningDate = null;
                            });
                          },
                        ),
                        spaceBetweenSections,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(StringResources.currentlyWorkingHereText),
                            Checkbox(
                              onChanged: (bool value) {
                                currentLyWorkingHere = value;
                                if (!currentLyWorkingHere) {
                                  _leavingDate = null;
                                }
                                setState(() {});
                              },
                              value: currentLyWorkingHere,
                            ),
                          ],
                        ),

                        /// Leaving Date
                        if (!currentLyWorkingHere)
                          CommonDatePickerFormField(
                            isRequired: true,
                            errorText: _leavingDateErrorText,
                            label: StringResources.leavingDateText,
                            date: _leavingDate,
                            onDateTimeChanged: (v) {
                              setState(() {
                                _leavingDate = v;
                                print(_leavingDate);
                              });
                            },
                            onTapDateClear: () {
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
      ),
    );
  }
}

//class ErrorWidget extends StatelessWidget {
//  final String errorText;
//  final Widget child;
//
//  ErrorWidget({
//    this.errorText,
//    @required this.child,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    if (errorText == null) {
//      return child;
//    } else {
//      return Container(
//        child: Wrap(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.all(8),
//              decoration: BoxDecoration(
//                  border: Border.all(
//                      color: Theme.of(context).errorColor, width: 2)),
//              child: child,
//            )
//          ],
//        ),
//      );
//    }
//  }
//}
