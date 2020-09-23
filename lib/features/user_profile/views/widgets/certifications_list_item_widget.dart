import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';

class CertificationsListItemWidget extends StatelessWidget {
  final CertificationInfo certificationInfo;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  final int index;
  const CertificationsListItemWidget({
    Key key,
    this.certificationInfo,this.isInEditMode,this.onTapEdit,this.onTapDelete, this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CachedNetworkImage(
          imageUrl: certificationInfo?.organization?.image??"",
          height: 60,
          width: 60,
          placeholder: (v,i)=>    Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.certificate,
                size: 45,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
        title: Text(certificationInfo.certificationName??"", key: Key('certificationTileNameKey'+index.toString()),),
        subtitle: Text(certificationInfo.organizationName??"",key: Key('certificationTileOrganizationNameKey'+index.toString())),
        trailing: !isInEditMode?SizedBox():Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(FontAwesomeIcons.edit),
              key: Key('certificationEditKey'+index.toString()),
              onPressed: onTapEdit,
              iconSize: 18,
              color: Colors.black,
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              key: Key('certificationDeleteKey'+index.toString()),
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
