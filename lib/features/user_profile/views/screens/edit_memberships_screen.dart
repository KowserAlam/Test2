import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';

class EditMemberShips extends StatefulWidget {
  @override
  _EditMemberShipsState createState() => _EditMemberShipsState();
}

class _EditMemberShipsState extends State<EditMemberShips> {
  final _formKey = GlobalKey<FormState>();


  //TextEditingController
  final _orgNameController = TextEditingController();
  final _positionHeldController = TextEditingController();
  final _membershipOngoingController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _descriptionController = TextEditingController();


  //FocusNodes
  final _orgNameFocusNode = FocusNode();
  final _positionHeldFocusNode = FocusNode();
  final _membershipOngoingFocusNode = FocusNode();
  final _startDateFocusNode = FocusNode();
  final _endDateFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();


  //widgets
  var spaceBetweenFields = SizedBox(height: 15,);
  @override
  Widget build(BuildContext context) {
    Function _onPressed = (){
      if(_formKey.currentState.validate()){
        print('validated');
      }else{
        print('not validated');
      }
    };


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
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership'),
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
                  //Organization Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _orgNameFocusNode,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_positionHeldFocusNode);
                    },
                    controller: _orgNameController,
                    labelText: StringUtils.membershipOrgNameText,
                    hintText: StringUtils.membershipOrgNameText,
                  ),
                  spaceBetweenFields,
                  //Position Held
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _positionHeldFocusNode,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_membershipOngoingFocusNode);
                    },
                    controller: _positionHeldController,
                    labelText: StringUtils.membershipPositionHeldText,
                    hintText: StringUtils.membershipPositionHeldText,
                  ),
                  spaceBetweenFields,
                  //Ongoing
                  CustomTextFormField(
                    validator: (val)=>Validator().validateEmail(val.trim()),
                    focusNode: _membershipOngoingFocusNode,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_startDateFocusNode);
                    },
                    controller: _membershipOngoingController,
                    labelText: StringUtils.membershipOngoingText,
                    hintText: StringUtils.membershipOngoingText,
                  ),
                  spaceBetweenFields,
                  //Start Date
                  CustomTextFormField(
                    validator: (val)=>Validator().validatePhoneNumber(val.trim()),
                    focusNode: _startDateFocusNode,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_endDateFocusNode);
                    },
                    controller: _startDateController,
                    labelText: StringUtils.membershipStartDateText,
                    hintText: StringUtils.membershipStartDateText,
                  ),
                  spaceBetweenFields,
                  CustomTextFormField(
                    validator: (val)=>Validator().validatePhoneNumber(val.trim()),
                    focusNode: _endDateFocusNode,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    controller: _endDateController,
                    labelText: StringUtils.membershipEndDateText,
                    hintText: StringUtils.membershipEndDateText,
                  ),
                  spaceBetweenFields,
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_descriptionFocusNode);
                    },
                    controller: _descriptionController,
                    labelText: StringUtils.membershipDescriptionText,
                    hintText: StringUtils.membershipDescriptionText,
                  ),
                  SizedBox(height: 40,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.max,children: <Widget>[Container(width: 150,child: CommonButton(label: 'Save',onTap: _onPressed,),)],),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
