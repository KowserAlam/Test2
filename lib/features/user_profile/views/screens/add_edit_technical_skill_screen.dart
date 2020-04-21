import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
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

  TextEditingController _skillTextEditingController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  //Values
  double rating;



  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var skillInfo = SkillInfo(
        skillId: widget.skillInfo?.skillId,
        rating: rating,
        skill: _skillTextEditingController.text
      );

      if (widget.skillInfo != null) {
        /// updating existing data

        Provider.of<UserProfileViewModel>(context, listen: false)
            .updateSkillData(skillInfo, widget.index)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      } else {
        /// adding new data
        Provider.of<UserProfileViewModel>(context, listen: false)
            .addSkillData(skillInfo)
            .then((value) {
          if (value) {
            Navigator.pop(context);
          }
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    rating = widget.skillInfo == null? 0.0 : widget.skillInfo.rating;
    super.initState();
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
                    controller: _skillTextEditingController,
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
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        rating.toString(),
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
