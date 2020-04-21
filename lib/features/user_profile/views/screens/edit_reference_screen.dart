

import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/repositories/user_profile_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/common_button.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:provider/provider.dart';

class EditReferenceScreen extends StatefulWidget {
  final ReferenceData referenceData;
  final int index;

  const EditReferenceScreen({
    this.referenceData,
    this.index,
  });

  @override
  _EditReferenceScreenState createState() => _EditReferenceScreenState();
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
  var spaceBetweenFields = SizedBox(
    height: 15,
  );

  initState() {
    if (widget.referenceData != null) {
      _nameController.text = widget.referenceData.name;
      _currentPositionController.text = widget.referenceData.currentPosition;
      _emailController.text = widget.referenceData.email;
      _mobileController.text = widget.referenceData.mobile;
    }
    super.initState();
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var referenceData = ReferenceData(
        referenceId: widget.referenceData?.referenceId,
        currentPosition: _currentPositionController.text,
        mobile: _mobileController.text,
        name: _nameController.text,
        email: _emailController.text,
      );

      if (widget.referenceData != null) {
        /// updating existing data

        Provider.of<UserProfileViewModel>(context, listen: false)
            .updateReferenceData(referenceData, widget.index)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      } else {
        /// adding new data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .addReferenceData(referenceData)
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
    var name = CustomTextFormField(
      validator: Validator().nullFieldValidate,
      keyboardType: TextInputType.text,
      focusNode: _nameFocusNode,
      autovalidate: true,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (a) {
        FocusScope.of(context).requestFocus(_currentPositionFocusNode);
      },
      controller: _nameController,
      labelText: StringUtils.referenceNameText,
      hintText: StringUtils.referenceNameText,
    );

    var currentPosition = CustomTextFormField(
      focusNode: _currentPositionFocusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (a) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
      controller: _currentPositionController,
      labelText: StringUtils.referenceCurrentPositionText,
      hintText: StringUtils.referenceCurrentPositionText,
    );
    var email = CustomTextFormField(
      validator: (val) => Validator().validateEmail(val.trim()),
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      autovalidate: true,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (a) {
        FocusScope.of(context).requestFocus(_mobileFocusNode);
      },
      controller: _emailController,
      labelText: StringUtils.referenceEmailText,
      hintText: StringUtils.referenceEmailText,
    );
    var mobile = CustomTextFormField(
      autovalidate: true,
      validator: (val) => Validator().validatePhoneNumber(val.trim()),
      focusNode: _mobileFocusNode,
      keyboardType: TextInputType.number,
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
                  currentPosition,
                  spaceBetweenFields,
                  //Email
                  email,
                  spaceBetweenFields,
                  //Mobile
                  mobile,
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
