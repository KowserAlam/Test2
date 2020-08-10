import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';

class MemberShipListItem extends StatelessWidget {
  final MembershipInfo memberShip;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  MemberShipListItem({
    Key key,
    @required this.memberShip,this.onTapEdit,this.isInEditMode,this.onTapDelete
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            height: 55,
            width: 55,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(FontAwesomeIcons.certificate)),
        title: Text(memberShip.orgName??""),
        subtitle: Text(memberShip.positionHeld??""),
        trailing: !isInEditMode?SizedBox():Row(
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
    );
  }


}
