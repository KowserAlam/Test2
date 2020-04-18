import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddEditTechnicalSkill extends StatefulWidget {
  final SkillInfo skillInfo;
  final int index;

  AddEditTechnicalSkill({this.skillInfo, this.index});

  @override
  _AddEditTechnicalSkillState createState() =>
      _AddEditTechnicalSkillState(this.skillInfo, this.index);
}

class _AddEditTechnicalSkillState extends State<AddEditTechnicalSkill> {
  final SkillInfo technicalSkill;
  final int index;

  _AddEditTechnicalSkillState(this.technicalSkill, this.index);

  TextEditingController _textEditingController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();



  _handleSave() {
    var isSuccess = _formKey.currentState.validate();

    if (isSuccess) {
 

      var education = SkillInfo(
        skill: _textEditingController.text,
        rating: 0,
      );

      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringUtils.professionalSkillText),
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
                Consumer<UserProfileViewModel>(
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
                Row(
                  children: <Widget>[
                    RatingBar(
                      initialRating:
                    0.0,
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

                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " 0.0",
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
