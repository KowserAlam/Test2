import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/models/organization.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/repositories/organization_list_repository.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:p7app/main_app/views/widgets/custom_auto_complete_text_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class EditCertification extends StatefulWidget {
  final CertificationInfo certificationInfo;
  final int index;
  final List<CertificationInfo> previouslyAddedCertificates;

  const EditCertification(
      {this.certificationInfo, this.index, this.previouslyAddedCertificates});

  @override
  _EditCertificationState createState() => _EditCertificationState();
}

class _EditCertificationState extends State<EditCertification> {
  final _formKey = GlobalKey<FormState>();
  bool hasExpiryDate;
  DateTime _issueDate, _expiryDate;
  String expiryDateErrorText, IssueDateErrorText;
  Organization selectedOrganization;

  //TextEditingController
  final _certificationNameController = TextEditingController();
  final _organizationNameController = TextEditingController();
  final _credentialIdController = TextEditingController();
  final _credentialUrlController = TextEditingController();

  //FocusNode
  final _certificationNameFocusNode = FocusNode();
  final _organizationNameFocusNode = FocusNode();
  final _credentialIdFocusNode = FocusNode();
  final _credentialUrlFocusNode = FocusNode();

  void submitData(CertificationInfo certificationInfo) {
    if (widget.certificationInfo == null) {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .addCertificationData(certificationInfo)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    } else {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .updateCertificationData(certificationInfo, widget.index)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    }
  }

  bool _validateDate() {
    if (hasExpiryDate) {
      if (_issueDate != null && _expiryDate != null) {
        bool isIssueDateBeforeExpireDate = _issueDate.isBefore(_expiryDate);
        if (!isIssueDateBeforeExpireDate) {
          expiryDateErrorText =
              StringResources.expireDateCanNotBeBeforeIssueDateText;
          setState(() {});
        }
        debugPrint("isBefore:$isIssueDateBeforeExpireDate");
        return isIssueDateBeforeExpireDate;
      }
      debugPrint("Null Date");
      return false;
    }

    return _issueDate != null;
  }

  bool validate() {
    bool isValid = _formKey.currentState.validate();
    setState(() {});
    return isValid && _validateDate();
  }

  _handleSave() {
    if (validate()) {
      var certificationInfo = CertificationInfo(
          certificationId: widget.certificationInfo?.certificationId,
          certificationName: _certificationNameController.text,
          organizationName: _organizationNameController.text,
          credentialUrl: _credentialUrlController.text,
          credentialId: _credentialIdController.text,
          organization: selectedOrganization,
          hasExpiryPeriod: hasExpiryDate,
          issueDate: _issueDate,
          expiryDate: _expiryDate);

      submitData(certificationInfo);
    } else {
      print('not validated');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    hasExpiryDate = false;
    if (widget.certificationInfo != null) {
      _certificationNameController.text =
          widget.certificationInfo.certificationName ?? "";
      _organizationNameController.text =
          widget.certificationInfo.organizationName ?? "";
      _credentialIdController.text =
          widget.certificationInfo.credentialId ?? "";
      _credentialUrlController.text =
          widget.certificationInfo.credentialUrl ?? "";
      _issueDate = widget.certificationInfo.issueDate ?? null;
      _expiryDate = widget.certificationInfo.expiryDate ?? null;
      hasExpiryDate = widget.certificationInfo.hasExpiryPeriod ?? false;
      _organizationNameController.text = widget.certificationInfo?.organization?.name??
          widget.certificationInfo.organizationName ?? "";
      selectedOrganization = widget.certificationInfo.organization;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenFields = SizedBox(
      height: 8,
    );
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.certificationsText, key: Key('certificationAppbarTitle'),),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringResources.saveText,
            onPressed: _handleSave,
            key: Key('certificationSaveButton'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Certification Name
                CustomTextFormField(
                  textFieldKey: Key('certificationName'),
                  isRequired: true,
                  validator: Validator().nullFieldValidate,
                  keyboardType: TextInputType.text,
                  focusNode: _certificationNameFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    FocusScope.of(context)
                        .requestFocus(_organizationNameFocusNode);
                  },
                  controller: _certificationNameController,
                  labelText: StringResources.certificationNameText,
                  hintText: StringResources.certificationNameText,
                ),
                spaceBetweenFields,
                //Organization Name
                // CustomTextFormField(
                //   //validator: Validator().nullFieldValidate,
                //   textFieldKey: Key('certificationOrganizationName'),
                //   keyboardType: TextInputType.text,
                //   focusNode: _organizationNameFocusNode,
                //   textInputAction: TextInputAction.next,
                //   onFieldSubmitted: (a) {
                //     FocusScope.of(context).requestFocus(_credentialIdFocusNode);
                //   },
                //   controller: _organizationNameController,
                //   labelText: StringResources.certificationOrganizationNameText,
                //   hintText: StringResources.certificationOrganizationNameText,
                // ),
                CustomAutoCompleteTextField<Organization>(
                    isRequired: true,
                    validator: Validator().nullFieldValidate,
                    textFieldKey: Key('certificationOrganizationName'),
                    focusNode: _organizationNameFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: _organizationNameController,
                    labelText: StringResources.certificationOrganizationNameText,
                    hintText: StringResources.certificationOrganizationNameText,
                    onSuggestionSelected: (v) {
                      _organizationNameController.text = v.name;
                      selectedOrganization = v;
                    },
                    itemBuilder: (c, o) => ListTile(
                      title: Text(o?.name ?? ""),
                    ),
                    suggestionsCallback: (q) async {
                      if(q.length<2){
                        return [];
                      }
                      return OrganizationListRepository()
                          .getCertifyingOrganizations(q);
                    }),
                //Credential Id
                spaceBetweenFields,
                CustomTextFormField(
                  //validator: Validator().nullFieldValidate,
                  textFieldKey: Key('certificationCredentialIdName'),
                  keyboardType: TextInputType.text,
                  focusNode: _credentialIdFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
                    FocusScope.of(context)
                        .requestFocus(_credentialUrlFocusNode);
                  },
                  controller: _credentialIdController,
                  labelText: StringResources.certificationCredentialIdText,
                  hintText: StringResources.certificationCredentialIdText,
                ),
                spaceBetweenFields,
                //Credential URL
                CustomTextFormField(
                  //validator: Validator().nullFieldValidate,
                  textFieldKey: Key('certificationCredentialUrl'),
                  keyboardType: TextInputType.text,
                  focusNode: _credentialUrlFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_organizationNameFocusNode);
                  },
                  controller: _credentialUrlController,
                  labelText: StringResources.certificationCredentialUrlText,
                  hintText: StringResources.certificationCredentialUrlText,
                ),
                spaceBetweenFields,
                CommonDatePickerFormField(
                  isRequired: true,
                  dateFieldKey: Key('certificationIssueDate'),
                  errorText: IssueDateErrorText,
                  label: StringResources.certificationIssueDateText,
                  date: _issueDate,
                  onDateTimeChanged: (v) {
                    setState(() {
                      _issueDate = v;
                    });
                  },
                  onTapDateClear: () {
                    setState(() {
                      _issueDate = null;
                    });
                  },
                ),
                //Has Expiry Date
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(StringResources.hasExpiryDateText),
                        Checkbox(
                          value: hasExpiryDate,
                          key: Key('certificationHasExpiryDate'),
                          onChanged: (bool newValue) {
                            if (newValue) {
                              hasExpiryDate = newValue;
                              setState(() {});
                            } else {
                              hasExpiryDate = newValue;
                              setState(() {});
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
                spaceBetweenFields,
                //ExpiryDate
                hasExpiryDate
                    ? CommonDatePickerFormField(
                        isRequired: hasExpiryDate,
                        dateFieldKey: Key('certificationExpiryDate'),
                        errorText: expiryDateErrorText,
                        label: StringResources.certificationExpiryDateText,
                        date: _expiryDate,
                        onDateTimeChanged: (v) {
                          setState(() {
                            _expiryDate = v;
                          });
                        },
                        onTapDateClear: () {
                          setState(() {
                            _expiryDate = null;
                          });
                        },
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
