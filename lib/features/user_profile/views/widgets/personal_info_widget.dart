import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';
import 'package:p7app/features/user_profile/views/screens/edit_personal_info_screen.dart';
import 'package:p7app/features/user_profile/views/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
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
      onTapEditAction: (v){
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    EditPersonalInfoScreen()));
      },
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: ProfileCommonStyle.boxShadow,),
          child: Consumer<UserProfileViewModel>(builder: (context, userProvider, _) {
            var personalInfo = userProvider.userData.personalInfo;
            return Column(
              children: <Widget>[
              SizedBox(height: 10,),
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
                    value: personalInfo.address),
                //permanent address
                _item(
                    context: context,
                    label: StringUtils.permanentAddersText,
                    value: personalInfo.address),
                //nationality
                _item(
                    context: context,
                    label: StringUtils.nationalityText,
                    value: personalInfo.nationality),
                //religion
                _item(
                    context: context,
                    label: StringUtils.religionText,
                    value: StringUtils.religionText),
              ],
            );
          }),
        )
      ],
    );
  }
}
