import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/certification_info.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';

class CertificationsListItemWidget extends StatelessWidget {
  final CertificationInfo certificationInfo;
  final Function onTapEdit;
  final bool isInEditMode;
  const CertificationsListItemWidget({
    Key key,
    this.certificationInfo,this.isInEditMode,this.onTapEdit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: ProfileCommonStyle.boxShadow,
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
        trailing: !isInEditMode?SizedBox():IconButton(
          icon: Icon(FontAwesomeIcons.edit),
          onPressed: onTapEdit,
        ),
      ),
    );
  }
}
