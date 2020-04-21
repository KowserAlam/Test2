import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class EditMemberShips extends StatefulWidget {
  final MembershipInfo membershipInfo;
  final int index;

  const EditMemberShips({this.membershipInfo, this.index});
  @override
  _EditMemberShipsState createState() => _EditMemberShipsState();
}

class _EditMemberShipsState extends State<EditMemberShips> {
  final _formKey = GlobalKey<FormState>();


  //TextEditingController
  final _orgNameController = TextEditingController();
  final _positionHeldController = TextEditingController();
  final _membershipOngoingController = TextEditingController();
  final _descriptionController = TextEditingController();


  //FocusNodes
  final _orgNameFocusNode = FocusNode();
  final _positionHeldFocusNode = FocusNode();
  final _membershipOngoingFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();


  //widgets
  var spaceBetweenFields = SizedBox(height: 15,);

  @override
  void initState() {
    // TODO: implement initState
    if(widget.membershipInfo != null){
      _orgNameController.text = widget.membershipInfo.orgName;
      _positionHeldController.text = widget.membershipInfo.positionHeld;
      _descriptionController.text = widget.membershipInfo.desceription;
    }
    super.initState();
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var membershipInfo = MembershipInfo(
        membershipId: widget.membershipInfo?.membershipId,
        orgName: _orgNameController.text,
        positionHeld: _positionHeldController.text,
        desceription: _descriptionController.text
      );

      if (widget.membershipInfo != null) {
        /// updating existing data

        Provider.of<UserProfileViewModel>(context, listen: false)
            .updateMembershipData(membershipInfo, widget.index)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      } else {
        /// adding new data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .addMembershipData(membershipInfo)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Membership'),
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
                    validator: Validator().nullFieldValidate,
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
                  spaceBetweenFields
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
