import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/validator.dart';

class EditPersonalInfoScreen extends StatefulWidget {

  @override
  _EditPersonalInfoScreenState createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends State<EditPersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    var fatherNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Father\'s name:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _fatherNameFocusNode,
              textInputAction: TextInputAction.next,
              controller: _fatherNameController,
            decoration: commonInputDecoration,
            style: textFieldFont,
            validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
    var motherNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Mother\'s name:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _motherNameFocusNode,
              textInputAction: TextInputAction.next,
              controller: _motherNameController,
              decoration: commonInputDecoration,
              style: textFieldFont,
              validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
    var nationalityNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nationality:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _nationalityFocusNode,
              textInputAction: TextInputAction.next,
              controller: _nationalityController,
              decoration: commonInputDecoration,
              style: textFieldFont,
              validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
    var religionNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Religion:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _religionFocusNode,
              textInputAction: TextInputAction.next,
              controller: _religionController,
              decoration: commonInputDecoration,
              style: textFieldFont,
              validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
    var currentAddressNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Current Address:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _currentAddressFocusNode,
              textInputAction: TextInputAction.next,
              controller: _currentAddressController,
              decoration: commonInputDecoration,
              style: textFieldFont,
              validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
    var permanentAddressNameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Permanent Address:', style: titleFont,),
        SizedBox(height: 5,),
        Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(1,1)
                )
              ]
          ),
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: _permanentAddressFocusNode,
              textInputAction: TextInputAction.next,
              controller: _permanentAddressController,
              decoration: commonInputDecoration,
              style: textFieldFont,
              validator: (val)=>Validator().nullFieldValidate(val.trim()),
//              onSaved: (val) => loginProvider.email = val.trim(),
//              onFieldSubmitted: (s) {
//                _emailFocus.unfocus();
//                FocusScope.of(_scaffoldKey.currentState.context)
//                    .requestFocus(_passwordFocus);
//              },
            ),
          ),
        )
      ],
    );
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
          child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      )],
    );

    _showDatePicker(context) {
      //var userProfileViewModel = Provider.of<UserProfileViewModel>(context,listen: false);
      var initialDate = DateTime.now().subtract(Duration(days: 356 * 18));
//      if (userProfileViewModel.user.dateOfBirth == null) {
//        initialDate = DateTime.now().subtract(Duration(days: 356 * 18));
//        userProfileViewModel.user.dateOfBirth = initialDate;
//        setState(() {});
//      } else {
//        initialDate = userProfileViewModel.user.dateOfBirth;
//      }

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
                          data: CupertinoThemeData(),
                          child: CupertinoDatePicker(
                            initialDateTime: initialDate,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (date) {
//                              var user = userProfileViewModel.user;
//                              user.dateOfBirth = date;
//                              userProfileViewModel.user = user;
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
    };
    var dob = Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,

      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0),
        child: InkWell(
          onTap: () {
            _showDatePicker(context);
          },
          child: TextFormField(
//            controller: userProfileViewModel.user.dateOfBirth != null
//                ? TextEditingController(
//                text: DateFormat("yMMMd").format(
//                    userProfileViewModel.user.dateOfBirth))
//                : TextEditingController(),
            enabled: false,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                BorderSide(color: Colors.grey, width: 1),
              ),
              border: InputBorder.none,
              labelStyle: TextStyle(
                  color: Theme.of(context).textTheme.title.color),
              hintStyle:
              TextStyle(color: Colors.grey.withOpacity(0.5)),
              labelText: 'Date of birth',
              hintText: 'Date of birth',
            ),
          ),
        ),
      ),
    );

    Widget buildForm(context){
      return Form(
        //key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            fatherNameInput,
            spaceBetweenFields,
            motherNameInput,
            spaceBetweenFields,
            currentAddressNameInput,
            spaceBetweenFields,
            permanentAddressNameInput,
            spaceBetweenFields,
            nationalityNameInput,
            spaceBetweenFields,
            religionNameInput,
            spaceBetweenFields,
            spaceBetweenFields,
          ],
        ),
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.personalInfoText),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              genderSelection,
              SizedBox(height: 10,),
              dob,
              spaceBetweenFields,
              buildForm(context),
              saveButton
            ],
          ),
        ),
      ),
    );
  }


}
