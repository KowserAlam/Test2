import 'package:p7app/features/user_profile/models/user_profile_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TechnicalSkillListItem extends StatelessWidget {
  final TechnicalSkill technicalSkill;
  final Function onTap;

  TechnicalSkillListItem({
    @required this.technicalSkill,
    @required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 5),
            leading: Padding(
              padding: const EdgeInsets.all(7.0),
              child: technicalSkill.isVerified ?? false
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
              technicalSkill.skillName,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .apply(color: Theme.of(context).primaryColor),
            ),
            trailing: Wrap(
              children: List.generate(5, (int index) {
                var iconData = Icons.star_border;

                if (technicalSkill.level > index) {
                  iconData = Icons.star;
                }

                if (technicalSkill.level > index && technicalSkill.level < index + 1) {
                  iconData = Icons.star_half;
                }
                return Icon(
                  iconData,
                  size: 17,
                  color: Colors.orange,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}