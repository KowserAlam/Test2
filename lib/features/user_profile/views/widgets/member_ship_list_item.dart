import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';

class MemberShipListItem extends StatelessWidget {
  final MembershipInfo memberShip;
  final Function onTapEdit;
  final bool isInEditMode;
  MemberShipListItem({
    @required this.memberShip,this.onTapEdit,this.isInEditMode
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: ProfileCommonStyle.boxShadow,),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            height: 55,
            width: 55,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(FontAwesomeIcons.certificate)),
        title: Text(memberShip.positionHeld??""),
        subtitle: Text(memberShip.orgName??""),
        trailing: !isInEditMode?SizedBox():IconButton(
          icon: Icon(FontAwesomeIcons.edit),
          onPressed: onTapEdit,
        ),
      ),
    );
  }


}
