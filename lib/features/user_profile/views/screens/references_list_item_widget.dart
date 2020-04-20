import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/user_profile/models/reference_data.dart';
import 'package:p7app/features/user_profile/styles/profile_common_style.dart';

class ReferencesListItemWidget extends StatelessWidget {
  final ReferenceData referenceData;
  final Function onTapEdit;
  final bool isInEditMode;
  const ReferencesListItemWidget({
    Key key,
    @required this.referenceData,this.isInEditMode,this.onTapEdit
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
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 55,
          width: 55,
          color: Theme.of(context).backgroundColor,
          child: Icon(FontAwesomeIcons.user),
        ),
        title: Text(referenceData.name??""),
        subtitle: Text(referenceData.currentPosition??""),
        trailing: !isInEditMode?SizedBox():Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.edit),
            onPressed: onTapEdit,
            iconSize: 18,
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.trash),
            onPressed: onTapEdit,
            iconSize: 18,
          ),
        ],),
      ),
    );
  }
}
