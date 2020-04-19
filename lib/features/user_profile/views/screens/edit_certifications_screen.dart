import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';

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
    Function _onPressed = (){
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
                  SizedBox(height: 40,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.max,children: <Widget>[Container(width: 150,child: CommonButton(label: 'Save',onTap: _onPressed,),)],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
