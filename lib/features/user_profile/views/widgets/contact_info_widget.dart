import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/features/user_profile/views/screens/edit_personal_info_screen.dart';
import 'package:p7app/features/user_profile/views/widgets/user_info_list_item.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:provider/provider.dart';

class ContactInfoWidget extends StatelessWidget {
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
            child: Text(": ${value??""}"),
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
      label: StringResources.contactInfo,
      onTapEditAction: (){
        var userModel =  Provider.of<UserProfileViewModel>(context, listen: false).userData;
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) =>
                    EditPersonalInfoScreen(userModel: userModel,)));
      },
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: CommonStyle.boxShadow,),
          child: Consumer<UserProfileViewModel>(builder: (context, userProvider, _) {
            var personalInfo = userProvider.userData.personalInfo;
            return Column(
              children: <Widget>[
                SizedBox(height: 10,),
                //phone
                _item(
                    context: context,
                    label: StringResources.phoneText,
                    value: personalInfo.phone != null? personalInfo.phone:""),
                //email
                _item(
                    context: context,
                    label: StringResources.emailText,
                    value: personalInfo.email != null? personalInfo.email:""),
                //address
                _item(
                    context: context,
                    label: StringResources.addressText,
                    value: personalInfo.address != null? personalInfo.address:""),
              ],
            );
          }),
        )
      ],
    );
  }
}
