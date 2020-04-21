import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';

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
        boxShadow: ProfileCommonStyle.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 5),
          leading: Padding(
            padding: const EdgeInsets.all(7.0),
            child: skillInfo.verifiedBySkillcheck ?? false
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
            skillInfo.skill,
            style: Theme.of(context)
                .textTheme
                .title
                .apply(color: Theme.of(context).primaryColor),
          ),
          trailing: !isInEditMode?
          Wrap(
            children: List.generate(5, (int index) {
              var iconData = Icons.star_border;

              if (skillInfo.rating > index) {
                iconData = Icons.star;
              }

              if (skillInfo.rating > index && skillInfo.rating < index + 1) {
                iconData = Icons.star_half;
              }
              return Icon(
                iconData,
                size: 17,
                color: Colors.orange,
              );
            }),
          ): Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.edit),
                onPressed: onTapEdit,
                iconSize: 18,
                color: Colors.black,
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.trash),
                onPressed: onTapDelete,
                iconSize: 18,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}