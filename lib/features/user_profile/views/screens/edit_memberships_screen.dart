import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/models/organization.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/repositories/organization_list_repository.dart';
import 'package:p7app/main_app/views/widgets/common_date_picker_form_field.dart';
import 'package:p7app/main_app/views/widgets/custom_auto_complete_text_field.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
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
  bool _membershipOngoing = true;
  String startDateErrorText, endDateErrorText;
  Organization selectedOrganization;
  //TextEditingController
  final _orgNameController = TextEditingController();
  final _positionHeldController = TextEditingController();
  ZefyrController _descriptionZefyrController =
      ZefyrController(NotusDocument());

  //FocusNodes
  final _orgNameFocusNode = FocusNode();
  final _positionHeldFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  //values
  DateTime _startDate;
  DateTime _endDate;

  //widgets
  var spaceBetweenFields = SizedBox(
    height: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    if (widget.membershipInfo != null) {
      _orgNameController.text = widget.membershipInfo.orgName;
      _positionHeldController.text = widget.membershipInfo.positionHeld;
      _descriptionZefyrController = ZefyrController(
          ZeyfrHelper.htmlToNotusDocument(widget.membershipInfo?.description));
      _startDate = widget.membershipInfo.startDate;
      _endDate = widget.membershipInfo.endDate;
      _membershipOngoing = widget.membershipInfo.membershipOngoing ?? false;
      _orgNameController.text = widget.membershipInfo?.organization?.name ?? widget.membershipInfo.orgName;
      selectedOrganization = widget.membershipInfo.organization;
    }
    super.initState();
  }

  void submitData(MembershipInfo membershipInfo) {
    if (widget.membershipInfo == null) {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .addMembershipData(membershipInfo)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    } else {
      Provider.of<UserProfileViewModel>(context, listen: false)
          .updateMembershipData(membershipInfo, widget.index)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    }
  }

  bool _validateDate() {
    if (!_membershipOngoing) {
      if (_startDate != null && _endDate != null) {
        bool isIssueDateBeforeExpireDate = _startDate.isBefore(_endDate);
        if (!isIssueDateBeforeExpireDate) {
          endDateErrorText = StringResources.endDateCanNotBeBeforeIssueDateText;
          setState(() {});
        }
        debugPrint("isBefore:$isIssueDateBeforeExpireDate");
        return isIssueDateBeforeExpireDate;
      }
      debugPrint("Null Date");
      return false;
    }

    return _startDate != null;
  }

  bool validate() {
    bool isValid = _formKey.currentState.validate();

    setState(() {});
    return isValid && _validateDate();
  }

  _handleSave() {
    var membershipInfo = MembershipInfo(
      membershipId: widget.membershipInfo?.membershipId,
      orgName: _orgNameController.text,
      positionHeld: _positionHeldController.text,
      description:
          ZeyfrHelper.notusDocumentToHTML(_descriptionZefyrController.document),
      membershipOngoing: _membershipOngoing??false,
      startDate: _startDate,
      endDate: !_membershipOngoing ? _endDate : null,
      organization: selectedOrganization
    );

    if (validate()) {
      if (_membershipOngoing) {
        submitData(membershipInfo);
      } else {
        if (_startDate.isBefore(_endDate)) {
          submitData(membershipInfo);
        } else {
          BotToast.showText(
              text: StringResources.membershipDateLogicWarningText);
        }
      }
    } else {
      print('not validated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringResources.membershipAppbarText,
          key: Key('membershipAppbarTitle'),
        ),
        actions: <Widget>[
          EditScreenSaveButton(
            text: StringResources.saveText,
            onPressed: _handleSave,
            key: Key('membershipSaveButton'),
          ),
        ],
      ),
      body: ZefyrScaffold(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Organization Name
                  CustomAutoCompleteTextField<Organization>(
                      isRequired: true,
                      validator: Validator().nullFieldValidate,
                      textFieldKey: Key('membershipOrganizationName'),
                      focusNode: _orgNameFocusNode,
                      controller: _orgNameController,
                      labelText: StringResources.membershipOrgNameText,
                      hintText: StringResources.membershipOrgNameText,
                      onSuggestionSelected: (v) {
                        _orgNameController.text = v.name;
                        selectedOrganization = v;
                      },
                      itemBuilder: (c, o) => ListTile(
                            title: Text(o?.name ?? ""),
                          ),
                      suggestionsCallback: (q) async {
                        if(q.length<2){
                          return [];
                        }
                        return OrganizationListRepository()
                              .getMembershipOrganizations(q);
                      }),
//                   CustomTextFormField(
//                     isRequired: true,
//                     validator: Validator().nullFieldValidate,
//                     textFieldKey: Key('membershipOrganizationName'),
//                     keyboardType: TextInputType.text,
//                     focusNode: _orgNameFocusNode,
//                     // autofocus: true,
//                     //textInputAction: TextInputAction.next,
//                     onFieldSubmitted: (a) {
// //                      FocusScope.of(context)
// //                          .requestFocus(_positionHeldFocusNode);
//                     },
//                     controller: _orgNameController,
//                     labelText: StringResources.membershipOrgNameText,
//                     hintText: StringResources.membershipOrgNameText,
//                   ),
                  spaceBetweenFields,
                  //Position Held
                  CustomTextFormField(
                    //validator: Validator().nullFieldValidate,
                    focusNode: _positionHeldFocusNode,
                    textFieldKey: Key('membershipPositionHeld'),
                    keyboardType: TextInputType.text,
                    //textInputAction: TextInputAction.next,
                    onFieldSubmitted: (a) {
//                      FocusScope.of(context)
//                          .requestFocus(_descriptionFocusNode);
                    },
                    controller: _positionHeldController,
                    labelText: StringResources.membershipPositionHeldText,
                    hintText: StringResources.membershipPositionHeldText,
                  ),
                  spaceBetweenFields,

                  //Description
                  CustomZefyrRichTextFormField(
                    labelText: StringResources.descriptionText,
                    zefyrKey: Key('membershipDescription'),
                    focusNode: _descriptionFocusNode,
                    controller: _descriptionZefyrController,
                  ),
                  spaceBetweenFields,
                  //Start Date
                  CommonDatePickerFormField(
                    isRequired: true,
                    errorText: startDateErrorText,
                    label: StringResources.startingDateText,
                    date: _startDate,
                    dateFieldKey: Key('membershipStartDate'),
                    onDateTimeChanged: (v) {
                      setState(() {
                        _startDate = v;
                      });
                    },
                    onTapDateClear: () {
                      setState(() {
                        _startDate = null;
                      });
                    },
                  ),
                  spaceBetweenFields,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: _membershipOngoing,
                            key: Key('membershipOngoing'),
                            onChanged: (bool newValue) {
                              if (newValue) {
                                _membershipOngoing = newValue;
                                setState(() {});
                              } else {
                                _membershipOngoing = newValue;
                                setState(() {});
                              }
                            },
                          ),
                          Text(StringResources.membershipOngoingText),
                        ],
                      )
                    ],
                  ),
                  spaceBetweenFields,
                  //End Date
                  !_membershipOngoing
                      ? CommonDatePickerFormField(
                          isRequired: !_membershipOngoing,
                          errorText: endDateErrorText,
                          label: StringResources.membershipEndDateText,
                          dateFieldKey: Key('membershipEndDate'),
                          date: _endDate,
                          onDateTimeChanged: (v) {
                            setState(() {
                              _endDate = v;
                            });
                          },
                          onTapDateClear: () {
                            setState(() {
                              _endDate = null;
                            });
                          },
                        )
                      : SizedBox(),
                  //Membership Ongoing

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
