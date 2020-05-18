import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/widgets/common_date_picker_widget.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
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
  bool _membershipOngoing = false;
  String blankStartingDateWarningText, blankEndingDateWarningText;


  //TextEditingController
  final _orgNameController = TextEditingController();
  final _positionHeldController = TextEditingController();
  final _descriptionController = TextEditingController();


  //FocusNodes
  final _orgNameFocusNode = FocusNode();
  final _positionHeldFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  //values
  DateTime _startDate;
  DateTime _endDate;

  //widgets
  var spaceBetweenFields = SizedBox(height: 15,);

  @override
  void initState() {
    // TODO: implement initState
    if(widget.membershipInfo != null){
      _orgNameController.text = widget.membershipInfo.orgName;
      _positionHeldController.text = widget.membershipInfo.positionHeld;
      _descriptionController.text = widget.membershipInfo.description;
      _startDate =  widget.membershipInfo.startDate;
      _endDate =  widget.membershipInfo.endDate;
      _membershipOngoing = widget.membershipInfo.membershipOngoing??false;
    }
    super.initState();
  }

  void addData(MembershipInfo membershipInfo){
    Provider.of<UserProfileViewModel>(context, listen: false)
        .addMembershipData(membershipInfo)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  void updateData(MembershipInfo membershipInfo){
    Provider.of<UserProfileViewModel>(context, listen: false)
        .updateMembershipData(membershipInfo, widget.index)
        .then((value) {
      if (value) {
        Navigator.pop(context);
      }
    });
  }

  bool validate(){
    bool isValid = _formKey.currentState.validate();
    bool checkDate(){
      if(_startDate != null){
        blankStartingDateWarningText = null;
        if(_membershipOngoing){
          _endDate = null;
          blankEndingDateWarningText = null;
          return true;
        }else{
          if(_endDate != null){
            blankEndingDateWarningText = null;
            return true;
          }else{
            blankEndingDateWarningText = StringUtils.membershipBlankEndDateWarningText;
            return false;
          }
        }
      }else{
        blankStartingDateWarningText = StringUtils.membershipBlankStartDateWarningText;
        return false;
      }
    }
    setState(() {

    });
    return isValid && checkDate();
  }

  _handleSave() {
    var membershipInfo = MembershipInfo(
      membershipId: widget.membershipInfo?.membershipId,
      orgName: _orgNameController.text,
      positionHeld: _positionHeldController.text,
      description: _descriptionController.text,
      membershipOngoing: _membershipOngoing,
      startDate: _startDate,
      endDate: !_membershipOngoing?_endDate:null,
    );

    if(validate()){
      if(_startDate.isBefore(_endDate)){
        if(widget.membershipInfo == null){
          addData(membershipInfo);
        }else{
          updateData(membershipInfo);
        }
      }else{
        BotToast.showText(text: StringUtils.membershipDateLogicWarningText);
      }
    }else{
      print('not validated');
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.membershipAppbarText),
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
                    //textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_positionHeldFocusNode);
                    },
                    controller: _orgNameController,
                    labelText: StringUtils.membershipOrgNameText,
                    hintText: StringUtils.membershipOrgNameText,
                  ),
                  spaceBetweenFields,
                  //Position Held
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    focusNode: _positionHeldFocusNode,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    //textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_descriptionFocusNode);
                    },
                    controller: _positionHeldController,
                    labelText: StringUtils.membershipPositionHeldText,
                    hintText: StringUtils.membershipPositionHeldText,
                  ),
                  spaceBetweenFields,
                  //Description
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
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
                  CommonDatePickerWidget(
                    errorText: blankStartingDateWarningText,
                    label: StringUtils.startingDateText,
                    date: _startDate,
                    onDateTimeChanged: (v){setState(() {
                      _startDate = v;
                    });},
                    onTapDateClear: (){
                      setState(() {
                        _startDate = null;
                      });
                    },
                  ),
                  //End Date
                  !_membershipOngoing?CommonDatePickerWidget(
                    errorText: blankEndingDateWarningText,
                    label: StringUtils.membershipEndDateText,
                    date: _endDate,
                    onDateTimeChanged: (v){setState(() {
                      _endDate = v;
                    });},
                    onTapDateClear: (){
                      setState(() {
                        _endDate = null;
                      });
                    },
                  ):SizedBox(),
                  //Membership Ongoing
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _membershipOngoing,
                            onChanged: (bool newValue){
                              if(newValue){
                                _membershipOngoing = newValue;
                                setState(() {});
                              }else{
                                _membershipOngoing = newValue;
                                setState(() {});
                              }
                            },
                          ),
                          Text('Membership ongoing'),
                        ],
                      )
                    ],
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
