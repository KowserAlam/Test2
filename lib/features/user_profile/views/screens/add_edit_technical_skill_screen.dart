import 'package:after_layout/after_layout.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_dropdown_button_form_field.dart';
import 'package:p7app/features/user_profile/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/failure/error.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/validator.dart';
import 'package:p7app/main_app/widgets/edit_screen_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:dartz/dartz.dart' as dartZ;

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
  List<DropdownMenuItem<Skill>> skillList = [];
  Skill _selectedDropdownSkill;

  //Values
  int rating;

  initState() {
    rating = widget.skillInfo == null ? 0 : widget.skillInfo.rating;
    _getSkillList();
    super.initState();
  }

  _handleSave() {
    bool isValid = _formKey.currentState.validate();
    if (isValid) {
      var skillInfo = SkillInfo(
        profSkillId: widget.skillInfo?.profSkillId,
        rating: rating,
        skill: _selectedDropdownSkill,
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

  _getSkillList() {
    SkillListRepository()
        .getSkillList()
        .then((dartZ.Either<AppError, List<Skill>> value) {
      value.fold((l) {
        // left
        BotToast.showText(text: StringUtils.unableToLoadSkillListText);
      }, (r) {
        // right
        skillList = r
            .map((e) => DropdownMenuItem<Skill>(
                  key: Key(e.name),
                  value: e,
                  child: Text(e.name ?? ""),
                ))
            .toList();
        setState(() {});
      });
    });
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
                CustomDropdownButtonFormField<Skill>(
                  labelText: StringUtils.skillNameText,
                  hint: Text('Tap to select'),
                  value: _selectedDropdownSkill,
                  onChanged: (value) {
                    _selectedDropdownSkill = value;
                    setState(() {});
                  },
                  items: skillList,
                ),
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
                      initialRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      unratedColor: Colors.grey,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value.round();
                        });
                      },
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${rating ?? ""}",
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
