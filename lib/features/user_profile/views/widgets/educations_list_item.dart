import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

import '../screens/add_edit_education_screen.dart';

class EducationsListItem extends StatelessWidget {
  final EduInfo eduInfoModel;
  final int index;
  final bool isInEditMode;
  final Function onTapEdit;
  final Function onTapDelete;

  EducationsListItem(
      {@required this.eduInfoModel,
      @required this.index,
      this.onTapDelete,
      this.onTapEdit,
      this.isInEditMode = false});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    String date = eduInfoModel.graduationDate != null ? DateFormatUtil.formatDate(eduInfoModel.graduationDate):"";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyleTextField.boxShadow,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 5),
        leading: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Icon(
              FontAwesomeIcons.university,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        title: Text(
          eduInfoModel.institutionObj?.name ??
              eduInfoModel.institutionText ??
              "",
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(eduInfoModel.degree ?? ""),
            Text(date),
          ],
        ),
        trailing: !isInEditMode
            ? null
            : Row(
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
