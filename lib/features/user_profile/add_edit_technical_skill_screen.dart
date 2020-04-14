import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/providers/education_provider.dart';
import 'package:p7app/features/user_profile/providers/technical_skill_provider.dart';
import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:p7app/features/user_profile/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddEditTechnicalSkill extends StatefulWidget {
  final TechnicalSkill technicalSkill;
  final int index;

  AddEditTechnicalSkill({this.technicalSkill, this.index});

  @override
  _AddEditTechnicalSkillState createState() =>
      _AddEditTechnicalSkillState(this.technicalSkill, this.index);
}

class _AddEditTechnicalSkillState extends State<AddEditTechnicalSkill>
    with AfterLayoutMixin {
  final TechnicalSkill technicalSkill;
  final int index;

  _AddEditTechnicalSkillState(this.technicalSkill, this.index);

  TextEditingController _textEditingController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    if (technicalSkill != null || index != null) {
      var technicalSkillProvider =
          Provider.of<TechnicalSkillProvider>(context, listen: false);
      technicalSkillProvider.skillLevel = technicalSkill.level;
      _textEditingController.text = technicalSkill.skillName;
    }
  }

  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {
      var technicalSkillProvider =
          Provider.of<TechnicalSkillProvider>(context, listen: false);

      var education = TechnicalSkill(
        skillName: _textEditingController.text,
        level: technicalSkillProvider.skillLevel,
      );

      if (education == null || index == null) {
        education.id = Uuid().v1();
        technicalSkillProvider.addData(context, education);
      } else {
        education.id = technicalSkill.id;
        technicalSkillProvider.updateData(
            _scaffoldKey.currentContext, education, index);
      }

      Navigator.pop(context);
      technicalSkillProvider.clearState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<TechnicalSkillProvider>(context, listen: false)
            .clearState();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(StringUtils.personalSkillText),
          actions: <Widget>[
            EditScreenSaveButton(
              text: "Save",
              onPressed: _handleSave,
            )
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
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<TechnicalSkillProvider>(
                      builder: (context, technicalSkillProvider, _) {
                    return CustomTextFormField(
                      validator: Validator().nullFieldValidate,
                      controller: _textEditingController,
                      labelText: StringUtils.skillNameText,
                      hintText: StringUtils.skillNameExample,
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    StringUtils.expertiseLevel,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<TechnicalSkillProvider>(
                      builder: (context, technicalSkillProvider, _) {
                    return Row(
                      children: <Widget>[
                        RatingBar(
                          initialRating:
                              technicalSkillProvider.skillLevel ?? 0.0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          unratedColor: Colors.grey,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            technicalSkillProvider.skillLevel = rating;
                          },
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${technicalSkillProvider.skillLevel ?? "0.0"}",
                            style: Theme.of(context).textTheme.display1,
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
