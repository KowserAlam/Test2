import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/user_profile/styles/common_style_text_field.dart';
import 'package:p7app/main_app/resource/const.dart';

class ExperienceListItem extends StatelessWidget {
  final ExperienceInfo experienceInfoModel;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;

  ExperienceListItem({this.experienceInfoModel, this.onTapEdit,this.isInEditMode,this.onTapDelete});

  @override
  Widget build(BuildContext context) {


    var backgroundColor = Theme.of(context).backgroundColor;


    String startDate = experienceInfoModel.startDate != null ?  "${DateFormat().add_yMMMd().format(experienceInfoModel.startDate)} " :"";
   String date = "$startDate"
        "- ${experienceInfoModel.endDate == null ? "Ongoing" : DateFormat().add_yMMMd().format(experienceInfoModel.endDate)}";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
        boxShadow:CommonStyleTextField.boxShadow,),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          kImagePlaceHolderAsset,
          height: 55,
          width: 55,
        ),
        title: Text(
          experienceInfoModel.organizationName??"",
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(experienceInfoModel.designation??""),
            Text(
              date,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
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
