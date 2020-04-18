import 'package:flutter/material.dart';
import 'package:p7app/main_app/util/validator.dart';

class EditReferenceScreen extends StatefulWidget {
  @override
  _EditReferenceScreenState createState() => _EditReferenceScreenState();
}

class _EditReferenceScreenState extends State<EditReferenceScreen> {
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
    var nameInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Name:', style: titleFont,),
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
              focusNode: _nameFocusNode,
              textInputAction: TextInputAction.next,
              controller: _nameController,
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
    var currentPositionInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Position:', style: titleFont,),
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
              focusNode: _currentPositionFocusNode,
              textInputAction: TextInputAction.next,
              controller: _currentPositionController,
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
    var emailInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email:', style: titleFont,),
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
              focusNode: _emailFocusNode,
              textInputAction: TextInputAction.next,
              controller: _emailController,
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
    var mobileInput = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Mobile No:', style: titleFont,),
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
              focusNode: _mobileFocusNode,
              textInputAction: TextInputAction.next,
              controller: _mobileController,
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
          child: Text('Save', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
      )],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Reference'),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              nameInput,
              spaceBetweenFields,
              currentPositionInput,
              spaceBetweenFields,
              emailInput,
              spaceBetweenFields,
              mobileInput,
              spaceBetweenFields,
              spaceBetweenFields,
              saveButton
            ],
          ),
        ),
      ),
    );
  }
}
