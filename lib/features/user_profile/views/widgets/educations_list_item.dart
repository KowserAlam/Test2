import 'package:p7app/features/user_profile/models/edu_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
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
    String graduationDateText = eduInfoModel.graduationDate != null
        ? DateFormatUtil.formatDate(eduInfoModel.graduationDate)
        : StringResources.ongoingText;
    String date =
        "${eduInfoModel.enrolledDate != null ? DateFormatUtil.formatDate(eduInfoModel.enrolledDate) : ""} - $graduationDateText";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyleTextField.boxShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.university,
                size: 45,
                color: Colors.grey[400],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eduInfoModel.institutionObj?.name ??
                      eduInfoModel.institutionText ??
                      "",style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(eduInfoModel.degree ?? "",style: TextStyle(fontSize: 13),),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isInEditMode)
            Row(
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
        ],
      ),
    );
  }
}
