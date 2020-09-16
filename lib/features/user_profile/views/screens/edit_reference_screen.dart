

import 'package:flutter/material.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/edit_screen_save_button.dart';
import 'package:p7app/method_extension.dart';
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

  ZefyrController _descriptionZefyrController =
  ZefyrController(NotusDocument());
  FocusNode _descriptionFocusNode = FocusNode();


  final _formKey = GlobalKey<FormState>();

  //widgets
  var spaceBetweenFields = SizedBox(
    height: 15
  );

  initState() {
    if (widget.referenceData != null) {
      _descriptionZefyrController =
          ZefyrController(widget.referenceData.description.htmlToNotusDocument);
    }
    super.initState();
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var referenceData = ReferenceData(
        referenceId: widget.referenceData?.referenceId,
        description: _descriptionZefyrController.document.toHTML.getStringInNotNull,
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


    // var description2 = CustomTextFormField(
    //   textFieldKey: Key('referencesDescription'),
    //   validator: Validator().nullFieldValidate,
    //   keyboardType: TextInputType.multiline,
    //   controller: _descriptionController,
    //   labelText: StringResources.referenceDescriptionText,
    //   hintText: StringResources.referenceDescriptionText,
    //   maxLength: 800,
    //   minLines: 5,
    //   maxLines: 18,
    // );
    var description = CustomZefyrRichTextFormField(
      labelText: StringResources.referenceDescriptionText,
      focusNode: _descriptionFocusNode,
      controller: _descriptionZefyrController,
      height: 250,
    );


    return ZefyrScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringResources.referenceAppbarText, key: Key('referencesAppbarTitle'),),
          actions: <Widget>[
            EditScreenSaveButton(
              key: Key('myProfileReferencesSaveButton'),
              text: StringResources.saveText,
              onPressed: _handleSave,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
