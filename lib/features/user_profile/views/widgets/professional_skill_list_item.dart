import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';

class ProfessionalSkillListItem extends StatelessWidget {
  final SkillInfo skillInfo;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;

  ProfessionalSkillListItem(
      {Key key,
      @required this.skillInfo,
      this.onTapDelete,
      this.onTapEdit,
      this.isInEditMode})
      : super(key: key);

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
        child: Row(
          children: [
            skillInfo.verifiedBySkillCheck ?? false
                ? Icon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.orange,
                    size: 17,
                  )
                : Icon(
                    FontAwesomeIcons.circle,
                    color: Colors.orange,
                    size: 17,
                  ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(skillInfo?.skill?.name ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: Theme.of(context).primaryColor)),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  skillInfo.rating == null
                      ? "N/A"
                      : skillInfo.rating.toString() + "/10",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: Theme.of(context).primaryColor),
                ),
                if (isInEditMode)
                  Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        InkWell(
                          child: Icon(
                            FontAwesomeIcons.edit,
                            size: 17,
                            color: Colors.black,
                          ),
                          onTap: onTapEdit,
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          child: Icon(
                            FontAwesomeIcons.trash,
                            color: Colors.black,
                            size: 17,
                          ),
                          onTap: onTapDelete,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}