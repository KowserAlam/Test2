import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:p7app/features/user_profile/models/company.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/repositories/company_list_repository.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/main_app/util/debouncer.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dartz/dartz.dart' as dartZ;

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
  int _experienceId;
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController positionNameController = TextEditingController();
  Debouncer _debouncer = Debouncer(milliseconds: 400);
  var _companyNameFocusNode = FocusNode();
  var _companyAutocompleteKey =
      new GlobalKey<AutoCompleteTextFieldState<Company>>();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Company> companySuggestion = [];
  String _companyNameErrorText;

  _AddNewExperienceScreenState(this.experienceModel, this.index);

  @override
  void initState() {
    // TODO: implement initState
    if (widget.experienceInfoModel != null) {
      _companyNameController.text =
          widget.experienceInfoModel.organizationName ?? "";
      positionNameController.text =
          widget.experienceInfoModel.designation ?? "";
      _joiningDate = widget.experienceInfoModel.startDate;
      _leavingDate = widget.experienceInfoModel.endDate;
      _selectedCompanyId = widget.experienceInfoModel.companyId;
      _experienceId = widget.experienceInfoModel.experienceId ?? null;
    }

    _companyNameController.addListener(() {
      if (_companyNameController.text.length > 3) {
        _companyAutocompleteKey.currentState.suggestions = [];
        _debouncer.run(() {
          CompanyListRepository()
              .getList(query: _companyNameController.text)
              .then((value) {
            value.fold((l) {
              //left
              print(l);
              _companyAutocompleteKey.currentState.suggestions = [];
            }, (List<Company> r) {
//              //right
              companySuggestion = r;
              _companyAutocompleteKey.currentState.updateSuggestions(r);
              _companyAutocompleteKey.currentState.updateOverlay();

//            setState(() {
//
//            });
            });
          });
        });
      }
    });
    super.initState();
  }

  bool sameExperience(String input) {
    int x = 0;
    for (int i = 0; i < widget.previouslyAddedExp.length; i++) {
      if (input == widget.previouslyAddedExp[i].organizationName) {
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
    !isNotEmpty
        ? _companyNameErrorText = StringUtils.thisFieldIsRequired
        : null;
    setState(() {});
    return isNotEmpty;
  }

  _handleSave() {
    var isSuccess = validate();
    if (isSuccess) {
      //Form validated
      if (_selectedCompanyId != null) {
        if (_companyNameController.text != _selectedCompanyId) {
          _selectedCompanyId = null;
//          setState(() {});
        }
      }
      var experienceInfo = ExperienceInfo(
          experienceId: widget.experienceInfoModel?.experienceId,
          organizationName: _companyNameController.text,
          designation: positionNameController.text,
          companyId: selectedCompany?.name ?? _selectedCompanyId,
          startDate: _joiningDate,
          endDate: _leavingDate);

      if (_joiningDate != null && _leavingDate != null) {
        if (_joiningDate.isBefore(_leavingDate)) {
          if (widget.experienceInfoModel != null) {
            print('1');
            if (widget.experienceInfoModel.organizationName !=
                _companyNameController.text) {
              print('1.1');
              if (sameExperience(_companyNameController.text)) {
                print('1.2');
                updateExp(experienceInfo);
              } else {
                print('1.3');
                BotToast.showText(text: StringUtils.sameExperience);
              }
            } else {
              print('1.4');
              updateExp(experienceInfo);
            }
          } else {
            print('1.5');
            if (sameExperience(_companyNameController.text)) {
              addExp(experienceInfo);
            } else {
              print('1.6');
              BotToast.showText(text: StringUtils.sameExperience);
            }
          }
        } else {
          print('1.5');
          BotToast.showText(text: StringUtils.joiningLeavingDateLogic);
        }
      } else {
        if (widget.experienceInfoModel != null) {
          print('2');
          if (widget.experienceInfoModel.organizationName !=
              _companyNameController.text) {
            print('2.1');
            if (sameExperience(_companyNameController.text)) {
              print('2.2');
              updateExp(experienceInfo);
            } else {
              print('2.3');
              BotToast.showText(text: StringUtils.sameExperience);
            }
          } else {
            print('2.4');
            updateExp(experienceInfo);
          }
        } else {
          if (sameExperience(_companyNameController.text)) {
            print('2.5');
            addExp(experienceInfo);
          } else {
            print('2.6');
            BotToast.showText(text: StringUtils.sameExperience);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenSections = SizedBox(
      height: 20,
    );

    var nameOfCompany = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("  " + StringUtils.nameOfCompany ?? "",
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
          child: AutoCompleteTextField<Company>(
            focusNode: _companyNameFocusNode,
            decoration: InputDecoration(
              hintText: StringUtils.currentCompanyHint,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              focusedBorder: CommonStyleTextField.focusedBorder(context),
            ),
            controller: _companyNameController,
            itemFilter: (Company suggestion, String query) => true,
            suggestions: companySuggestion,
            itemSorter: (Company a, Company b) => a.name.compareTo(b.name),
            key: _companyAutocompleteKey,
            itemBuilder: (BuildContext context, Company suggestion) {
              return ListTile(
                title: Text(suggestion.name ?? ""),
              );
            },
            clearOnSubmit: false,
            itemSubmitted: (Company data) {
              selectedCompany = data;
//                    _companyNameController.text = data.name;
              _companyAutocompleteKey.currentState.updateSuggestions([]);
              setState(() {});
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
    var name = TypeAheadFormField<Company>(

      textFieldConfiguration: TextFieldConfiguration(
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(border: OutlineInputBorder())),
      suggestionsCallback: (pattern) async {
        return await CompanyListRepository()
            .getList(query: pattern)
            .then((value) => value.fold((l) => <Company>[], (r) => r));
      },
      itemBuilder: (context,Company suggestion) {
        return ListTile(
          title: Text(suggestion.name),
        );
      },
      onSuggestionSelected: (suggestion) {
        selectedCompany = suggestion;
//                    _companyNameController.text = data.name;
        _companyAutocompleteKey.currentState.updateSuggestions([]);
        setState(() {});
      },
    );

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(StringUtils.professionalExperienceText),
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
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      nameOfCompany,
//                      name,
                      spaceBetweenSections,

                      /// Position
                      CustomTextFormField(
                        //validator: Validator().nullFieldValidate,
                        controller: positionNameController,
                        labelText: StringUtils.positionText,
                        hintText: StringUtils.positionTextEg,
                        autofocus: false,
                      ),
                      spaceBetweenSections,

                      /// Joining Date
                      CommonDatePickerWidget(
                        label: StringUtils.joiningDateText,
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

                      /// Leaving Date
                      CommonDatePickerWidget(
                        label: StringUtils.leavingDateText,
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
