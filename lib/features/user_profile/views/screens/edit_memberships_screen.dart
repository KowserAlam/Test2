import 'package:flutter/cupertino.dart';
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
                          .requestFocus(_descriptionFocusNode);
                    },
                    controller: _membershipOngoingController,
                    labelText: StringUtils.membershipOngoingText,
                    hintText: StringUtils.membershipOngoingText,
                  ),
                  spaceBetweenFields,
                  //Description
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    maxLines: null,
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
                  spaceBetweenFields,

                  //Start Date
                  Row(
                    children: <Widget>[
                      Text(
                        StringUtils.membershipStartDateText,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  InkWell(
                    onTap: () {
                      _showStartDatePicker(context);
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
                        "SD",
                      ),
                    ),
                  ),
                  spaceBetweenFields,

                  //End Date
                  Row(
                    children: <Widget>[
                      Text(
                        StringUtils.membershipEndDateText,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  InkWell(
                    onTap: () {
                      _showEndDatePicker(context);
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
                        "ED",
                      ),
                    ),
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

  _showEndDatePicker(context) {

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
  _showStartDatePicker(context) {

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
