import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';

class EditCertification extends StatefulWidget {
  @override
  _EditCertificationState createState() => _EditCertificationState();
}

class _EditCertificationState extends State<EditCertification> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    Function _handleSave = (){
      if(_formKey.currentState.validate()){
        print('validated');
      }else{
        print('not validated');
      }
    };
    var spaceBetweenFields = SizedBox(height: 15,);

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
                        "ID",
                      ),
                    ),
                  ),
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
                          onDateTimeChanged: (v){},
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
                          onDateTimeChanged: (v){},
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
