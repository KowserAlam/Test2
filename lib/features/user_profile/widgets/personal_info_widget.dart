import 'package:assessment_ishraak/features/user_profile/providers/user_provider.dart';
import 'package:assessment_ishraak/features/user_profile/widgets/edit_personal_info_screen.dart';
import 'package:assessment_ishraak/features/user_profile/widgets/user_info_list_item.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PersonalInfoWidget extends StatelessWidget {
  Widget _item(
      {@required BuildContext context,
      @required String label,
      @required String value}) {
    double width = MediaQuery.of(context).size.width > 720 ? 160 : 130;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: width,
            child: Text(
              "$label",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(": $value"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return UserInfoListItem(
      useSeparator: false,
      icon: FontAwesomeIcons.infoCircle,
      label: StringUtils.personalInfoText,
      expandedChildren: <Widget>[
        Material(
          color: Theme.of(context).canvasColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
            child: Consumer<UserProvider>(builder: (context, userProvider, _) {
              var personalInfo = userProvider.userData.personalInfo;
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ///Edit button
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      EditPersonalInfoScreen()));
                        },
                        child: Text(
                          StringUtils.editText,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .apply(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  //dob
                  _item(
                      context: context,
                      label: StringUtils.dateOfBirthText,
                      value: kDateFormatBD.format(personalInfo.dateOfBirth)),
                  //gender
                  _item(
                      context: context,
                      label: StringUtils.genderText,
                      value: personalInfo.gender),
                  //father name
                  _item(
                      context: context,
                      label: StringUtils.fatherNameText,
                      value: personalInfo.fatherName),
                  //mother name
                  _item(
                      context: context,
                      label: StringUtils.motherNameText,
                      value: personalInfo.motherName),

                  //current address
                  _item(
                      context: context,
                      label: StringUtils.currentAddersText,
                      value: personalInfo.currentAddress),
                  //permanent address
                  _item(
                      context: context,
                      label: StringUtils.permanentAddersText,
                      value: personalInfo.permanentAddress),
                  //nationality
                  _item(
                      context: context,
                      label: StringUtils.nationalityText,
                      value: personalInfo.nationality),
                  //religion
                  _item(
                      context: context,
                      label: StringUtils.religionText,
                      value: personalInfo.religion),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
