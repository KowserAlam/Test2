import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/skill_info.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';

class ProfessionalSkillListItem extends StatelessWidget {
  final SkillInfo skillInfo;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  final int index;

  ProfessionalSkillListItem(
      {Key key,
      @required this.skillInfo,
      this.onTapDelete,
      this.onTapEdit,
      this.isInEditMode = false,
      this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context)
        .textTheme
        .subtitle2
        .apply();
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: skillInfo.verifiedBySkillCheck ?? false
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
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                skillInfo?.skill?.name ?? "",
                style: titleStyle,
                key: Key('tileSkillName'+index.toString()),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  skillInfo.rating == null
                      ? "N/A"
                      : skillInfo.rating.toInt().toString() + "/10",
                  style: titleStyle,
                ),
                if (isInEditMode)
                  Material(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Icon(
                              FontAwesomeIcons.edit,
                              size: 17,
                              color: Colors.black,
                              key: Key('skillEditButton'+index.toString()),
                            ),
                          ),
                          onTap: onTapEdit,
                        ),
//                        SizedBox(width: 25),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.black,
                              key: Key('skillDeleteButton'+index.toString()),
                              size: 17,
                            ),
                          ),
                          onTap: onTapDelete,
                        ),
//                        SizedBox(width: 15),
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
