import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';

class TechnicalSkillListItem extends StatelessWidget {
  final SkillInfo skillInfo;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;

  TechnicalSkillListItem({
    Key key,
    @required this.skillInfo, this.onTapDelete, this.onTapEdit, this.isInEditMode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyleTextField.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5),
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: skillInfo.verifiedBySkillCheck ?? false
                ? Icon(
              FontAwesomeIcons.checkCircle,
              color: Colors.orange,
            )
                : Icon(
              FontAwesomeIcons.circle,
              color: Colors.orange,
            ),
          ),
          title: Text(
            skillInfo?.skill?.name??"",
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).primaryColor),
          ),
          trailing:
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(skillInfo.rating == null?"N/A":skillInfo.rating.toString()+"/10", style: Theme.of(context)
                  .textTheme
                  .title
                  .apply(color: Theme.of(context).primaryColor),),
              isInEditMode?SizedBox(width: 5,):SizedBox(),
              isInEditMode?IconButton(
                icon: Icon(FontAwesomeIcons.edit),
                onPressed: onTapEdit,
                iconSize: 18,
                color: Colors.black,
              ):SizedBox(),
              isInEditMode?IconButton(
                icon: Icon(FontAwesomeIcons.trash),
                onPressed: onTapDelete,
                iconSize: 18,
                color: Colors.black,
              ):SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}