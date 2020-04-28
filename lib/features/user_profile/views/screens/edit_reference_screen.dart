

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
  final _descriptionController = TextEditingController();

  //FocusNodes
  final _descriptionFocusNode = FocusNode();

  //widgets
  var spaceBetweenFields = SizedBox(
    height: 15,
  );

  initState() {
    if (widget.referenceData != null) {
      _descriptionController.text = widget.referenceData.description;
    }
    super.initState();
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var referenceData = ReferenceData(
        referenceId: widget.referenceData?.referenceId,
        description: _descriptionController.text,
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
    var description = CustomTextFormField(
      validator: Validator().nullFieldValidate,
      keyboardType: TextInputType.text,
      focusNode: _descriptionFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (a) {

      },
      controller: _descriptionController,
      labelText: StringUtils.referenceDescriptionText,
      hintText: StringUtils.referenceDescriptionText,
    );


    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.referenceAppbarText),
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
                  description,
                  spaceBetweenFields,
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
