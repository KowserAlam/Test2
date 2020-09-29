import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/member_ship_info.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';

class MemberShipListItem extends StatelessWidget {
  final MembershipInfo memberShip;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  final int index;
  MemberShipListItem({
    Key key,
    @required this.memberShip,this.onTapEdit,this.isInEditMode,this.onTapDelete, this.index
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
        leading: CachedNetworkImage(
          imageUrl: memberShip?.organization?.image??kOrganizationNetworkImagePlaceholder,
          height: 55,
          width: 55,
          placeholder: (v,i)=>    Center(
            child: Icon(
              FontAwesomeIcons.certificate,
              size: 47,
              color: Colors.grey[700],
            ),
          ),
        ),
        title: Text(memberShip.orgName??"", key: Key('membershipTileOrganizationName'+index.toString()),),
        subtitle: Text(memberShip.positionHeld??"", key: Key('membershipTilePositionHeld'+index.toString())),
        trailing: !isInEditMode?SizedBox():Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.edit),
              key: Key('membershipEditKey'+index.toString()),
              onPressed: onTapEdit,
              iconSize: 18,
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              key: Key('membershipDeleteKey'+index.toString()),
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
