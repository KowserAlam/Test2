import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/common_date_picker_widget.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class EditCertification extends StatefulWidget {
  final CertificationInfo certificationInfo;
  final int index;

  const EditCertification({
    this.certificationInfo ,
    this.index,
  });
  @override
  _EditCertificationState createState() => _EditCertificationState();
}

class _EditCertificationState extends State<EditCertification> {
  final _formKey = GlobalKey<FormState>();
  bool  hasExpiryDate;
  DateTime _issueDate, _expirydate;

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


  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var certificationData = CertificationInfo(
        certificationId: widget.certificationInfo?.certificationId,
        certificationName: _certificationNameController.text,
        organizationName: _organizationNameController.text,
        credentialUrl: _credentialUrlController.text,
        credentialId: _credentialIdController.text,
        hasExpiryPeriod: hasExpiryDate,
        issueDate: _issueDate,
      );

      if (widget.certificationInfo != null) {
        /// updating existing data

        Provider.of<UserProfileViewModel>(context, listen: false)
            .updateCertificationData(certificationData, widget.index)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      } else {
        /// adding new data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .addCertificationData(certificationData)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    hasExpiryDate = false;
    if(widget.certificationInfo != null){
      _certificationNameController.text = widget.certificationInfo.certificationName?? "";
      _organizationNameController.text = widget.certificationInfo.organizationName?? "";
      _credentialIdController.text = widget.certificationInfo.credentialId?? "";
      _credentialUrlController.text = widget.certificationInfo.credentialUrl?? "";
      _issueDate = widget.certificationInfo.issueDate??null;
      hasExpiryDate = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenFields = SizedBox(height: 15,);;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cetification'),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringUtils.saveText,
            onPressed: _handleSave,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Certification Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _certificationNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_organizationNameFocusNode);
                    },
                    controller: _certificationNameController,
                    labelText: StringUtils.certificationNameText,
                    hintText: StringUtils.certificationNameText,
                  ),
                  spaceBetweenFields,
                  //Organization Name
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _organizationNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_credentialIdFocusNode);
                    },
                    controller: _organizationNameController,
                    labelText: StringUtils.certificationOrganizationNameText,
                    hintText: StringUtils.certificationOrganizationNameText,
                  ),
                  //Credential Id
                  spaceBetweenFields,
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _credentialIdFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_credentialUrlFocusNode);
                    },
                    controller: _credentialIdController,
                    labelText: StringUtils.certificationCredentialIdText,
                    hintText: StringUtils.certificationCredentialIdText,
                  ),
                  spaceBetweenFields,
                  //Credential URL
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _credentialUrlFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_organizationNameFocusNode);
                    },
                    controller: _credentialUrlController,
                    labelText: StringUtils.certificationCredentialUrlText,
                    hintText: StringUtils.certificationCredentialUrlText,
                  ),
                  spaceBetweenFields,
                  CommonDatePickerWidget(
                    label: StringUtils.certificationIssueDateText,
                    date: _issueDate,
                    onDateTimeChanged: (v){
                      setState(() {_issueDate = v;});
                    },
                    onTapDateClear: (){
                      setState(() {_issueDate = null;});
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Has Expiry date'),
                          Checkbox(
                            value: hasExpiryDate,
                            onChanged: (bool newValue){
                              if(newValue){
                                hasExpiryDate = newValue;
                                setState(() {});
                              }else{
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
                  hasExpiryDate?CommonDatePickerWidget(
                    label: StringUtils.certificationExpiryDateText,
                    date: _expirydate,
                    onDateTimeChanged: (v){
                      setState(() {_expirydate = v;});
                    },
                    onTapDateClear: (){
                      setState(() {_expirydate = null;});
                    },
                  ):SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
