import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';

class EditPersonalInfoScreen extends StatefulWidget {

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  //TextEditingController
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _currentAddressController = TextEditingController();
  final _permanentAddressController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _religionController = TextEditingController();

  //FocusNode
  final _fatherNameFocusNode = FocusNode();
  final _motherNameFocusNode = FocusNode();
  final _nationalityFocusNode = FocusNode();
  final _currentAddressFocusNode = FocusNode();
  final _permanentAddressFocusNode = FocusNode();
  final _religionFocusNode = FocusNode();

  //Variables
  String radioValue;
  String _gender;
  @override
  void initState() {
    // TODO: implement initState
    radioValue = 'one';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Function _onPressed = (){
      if(_formKey.currentState.validate()){
        print('validated');
      }else{
        print('not validated');
      }
    };
    //TextStyle
    TextStyle titleFont = TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);


    void radioButtonChanges(String value) {
      setState(() {
        radioValue = value;
        switch (value) {
          case 'one':
            _gender = 'Male';
            print(_gender);
            break;
          case 'two':
            _gender = 'Female';
            print(_gender);
            break;
          default:
            _gender = 'Male';
        }
      });
    }

    var spaceBetweenFields = SizedBox(height: 15,);
    var genderSelection = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 5,),
        Text('Gender:',style: titleFont,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  groupValue: radioValue,
                  value: 'one',
                  onChanged: radioButtonChanges,
                ),
                Text('Male', style: TextStyle(),),
              ],
            ),
            SizedBox(width: 10,),
            Row(
              children: <Widget>[
                Radio(
                  groupValue: radioValue,
                  value: 'two',
                  onChanged: radioButtonChanges,
                ),
                Text('Female', style: TextStyle(),),
              ],
            )
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.personalInfoText),
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
                  //Gender
                  genderSelection,
                  spaceBetweenFields,
                  //Father's Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _fatherNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_motherNameFocusNode);
                    },
                    controller: _fatherNameController,
                    labelText: StringUtils.fatherNameText,
                    hintText: StringUtils.fatherNameText,
                  ),
                  spaceBetweenFields,
                  //Mother's Name
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _motherNameFocusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_currentAddressFocusNode);
                    },
                    controller: _motherNameController,
                    labelText: StringUtils.motherNameText,
                    hintText: StringUtils.motherNameText,
                  ),
                  spaceBetweenFields,
                  //Current Address
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _currentAddressFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_permanentAddressFocusNode);
                    },
                    controller: _currentAddressController,
                    labelText: StringUtils.currentAddressText,
                    hintText: StringUtils.currentAddressText,
                  ),
                  spaceBetweenFields,
                  //Permanent Address
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _permanentAddressFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_nationalityFocusNode);
                    },
                    controller: _permanentAddressController,
                    labelText: StringUtils.permanentAddressText,
                    hintText: StringUtils.permanentAddressText,
                  ),
                  spaceBetweenFields,
                  //Nationality
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    focusNode: _nationalityFocusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
                      FocusScope.of(context)
                          .requestFocus(_religionFocusNode);
                    },
                    controller: _nationalityController,
                    labelText: StringUtils.nationalityText,
                    hintText: StringUtils.nationalityText,
                  ),
                  spaceBetweenFields,
                  //Religion
                  CustomTextFormField(
                    validator: Validator().nullFieldValidate,
                    keyboardType: TextInputType.text,
                    focusNode: _religionFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_religionFocusNode);
                    },
                    controller: _religionController,
                    labelText: StringUtils.religionText,
                    hintText: StringUtils.religionText,
                  ),
                  SizedBox(height: 40,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,mainAxisSize: MainAxisSize.max,children: <Widget>[Container(width: 150,child: CommonButton(label: 'Save',onTap: _onPressed,),)],),
//                  InkWell(
//                    onTap: () {
//                      _showJoinDatePicker(context);
//                    },
//                    child: Container(
//                      width: double.infinity,
//                      decoration: BoxDecoration(
//                        color: Theme.of(context).backgroundColor,
//                        borderRadius: BorderRadius.circular(7),
//                        boxShadow: [
//                          BoxShadow(color: Color(0xff000000).withOpacity(0.2), blurRadius: 20),
//                          BoxShadow(color: Color(0xfffafafa).withOpacity(0.2), blurRadius: 20),
//
//                        ],),
//                      padding: EdgeInsets.all(8),
//                      child: Text(
//                        "",
//                      ),
//                    ),
//                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
