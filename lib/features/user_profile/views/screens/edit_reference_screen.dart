import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';

class EditReferenceScreen extends StatefulWidget {
  final ReferenceData referenceData;




  @override
  _EditReferenceScreenState createState() => _EditReferenceScreenState();

  const EditReferenceScreen({
    this.referenceData,
  });
}

class _EditReferenceScreenState extends State<EditReferenceScreen> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingController
  final _nameController = TextEditingController();
  final _currentPositionController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  //FocusNodes
  final _nameFocusNode = FocusNode();
  final _currentPositionFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();

  //widgets
  var spaceBetweenFields = SizedBox(height: 15,);

  _handleSave(){

  }

  @override
  Widget build(BuildContext context) {




    var name = CustomTextFormField(
      validator: Validator().nullFieldValidate,
      keyboardType: TextInputType.text,
      focusNode: _nameFocusNode,
      autofocus: true,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (a) {
        FocusScope.of(context)
            .requestFocus(_currentPositionFocusNode);
      },
      controller: _nameController,
      labelText: StringUtils.referenceNameText,
      hintText: StringUtils.referenceNameText,
    );

var currentPosition = CustomTextFormField(
  validator: Validator().nullFieldValidate,
  focusNode: _currentPositionFocusNode,
  keyboardType: TextInputType.text,
  autofocus: true,
  textInputAction: TextInputAction.next,
  onFieldSubmitted: (a) {
    FocusScope.of(context)
        .requestFocus(_emailFocusNode);
  },
  controller: _currentPositionController,
  labelText: StringUtils.referenceCurrentPositionText,
  hintText: StringUtils.referenceCurrentPositionText,
);
var email = CustomTextFormField(
  validator: (val)=>Validator().validateEmail(val.trim()),
  focusNode: _emailFocusNode,
  keyboardType: TextInputType.emailAddress,
  autofocus: true,
  textInputAction: TextInputAction.next,
  onFieldSubmitted: (a) {
    FocusScope.of(context)
        .requestFocus(_mobileFocusNode);
  },
  controller: _emailController,
  labelText: StringUtils.referenceEmailText,
  hintText: StringUtils.referenceEmailText,
);
var mobile = CustomTextFormField(
  validator: (val)=>Validator().validatePhoneNumber(val.trim()),
  focusNode: _mobileFocusNode,
  keyboardType: TextInputType.number,
  autofocus: true,
  onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_nationalityFocusNode);
  },
  controller: _mobileController,
  labelText: StringUtils.referenceMobileText,
  hintText: StringUtils.referenceMobileText,
);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reference'),
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
                  //Name
                  name,
                  spaceBetweenFields,
                  //Current Position
                  currentPosition
                  ,
                  spaceBetweenFields,
                  //Email
                  email,
                  spaceBetweenFields,
                  //Mobile
                  mobile,
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
