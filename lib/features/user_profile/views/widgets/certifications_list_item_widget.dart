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
        leading: Container(
            height: 55,
            width: 55,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(FontAwesomeIcons.certificate)),
        title: Text(certificationInfo.certificationName??""),
        subtitle: Text(certificationInfo.organizationName??""),
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
