import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
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
        expiryDate: kDateFormatBD.format(_expirydate),
        issueDate: kDateFormatBD.format(_issueDate),
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
      _certificationNameController.text = widget.certificationInfo.certificationName;
      _organizationNameController.text = widget.certificationInfo.organizationName;
      _credentialIdController.text = widget.certificationInfo.credentialId;
      _credentialUrlController.text = widget.certificationInfo.credentialUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var spaceBetweenFields = SizedBox(height: 15,);
    var expirydate = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
                StringUtils.certificationExpiryDateText,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),

        InkWell(
          onTap: () {
            _showExpiryDatePicker(context);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
              ],),
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Text(
                "Expiry Date",
              )],
            ),
          ),
        ),
      ],
    );
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
                    validator: Validator().nullFieldValidate,
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
                    validator: Validator().nullFieldValidate,
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
                    validator: Validator().nullFieldValidate,
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
                  Row(
                    children: <Widget>[
                      Text(
                        StringUtils.joiningDateText,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  InkWell(
                    onTap: () {
                      _showIssueDatePicker(context);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
                          BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
                        ],),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Issue Date",
                      ),
                    ),
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
                  hasExpiryDate?expirydate:SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showIssueDatePicker(context) {

    var initialDate = DateTime.now();

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
                        data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v){
                            setState(() {
                              _issueDate = v;
                            });
                          },
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

  _showExpiryDatePicker(context) {

    var initialDate = DateTime.now();

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
                        data: CupertinoThemeData(brightness: Theme.of(context).brightness),
                        child: CupertinoDatePicker(
                          initialDateTime: initialDate,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (v){
                            setState(() {
                              _expirydate = v;
                            });
                          },
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
