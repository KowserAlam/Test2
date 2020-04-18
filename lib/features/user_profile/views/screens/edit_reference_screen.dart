import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';

class EditReferenceScreen extends StatefulWidget {
  @override
  _EditReferenceScreenState createState() => _EditReferenceScreenState();
}

class _EditReferenceScreenState extends State<EditReferenceScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //TextStyle
    TextStyle titleFont = TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
    TextStyle textFieldFont = TextStyle(fontSize: 15, color: Colors.black);

    //InputDecoration
    InputDecoration commonInputDecoration = InputDecoration(
//    contentPadding: EdgeInsets.zero,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.lightBlueAccent,
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      //border: InputBorder.none,
    );

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

    var saveButton = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Container(
        height: 50,
        width: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue
        ),
        child: Center(
          child: Text('Save', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      )],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reference'),
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
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
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
                  ),
                  spaceBetweenFields,
                  //Current Position
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _currentPositionFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_emailFocusNode);
                    },
                    controller: _currentPositionController,
                    labelText: StringUtils.referenceCurrentPositionText,
                    hintText: StringUtils.referenceCurrentPositionText,
                  ),
                  spaceBetweenFields,
                  //Email
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _emailFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_mobileFocusNode);
                    },
                    controller: _emailController,
                    labelText: StringUtils.referenceEmailText,
                    hintText: StringUtils.referenceEmailText,
                  ),
                  spaceBetweenFields,
                  //Mobile
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _mobileFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_nationalityFocusNode);
                    },
                    controller: _mobileController,
                    labelText: StringUtils.referenceMobileText,
                    hintText: StringUtils.referenceMobileText,
                  ),
                  spaceBetweenFields,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
