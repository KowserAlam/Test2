import 'package:cached_network_image/cached_network_image.dart';
import 'package:p7app/features/user_profile/models/experience_info.dart';
import 'package:p7app/features/user_profile/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

class ExperienceListItem extends StatelessWidget {
  final ExperienceInfo experienceInfoModel;
  final Function onTapEdit;
  final Function onTapDelete;
  final bool isInEditMode;
  final int index;

  ExperienceListItem(
      {this.experienceInfoModel,
      this.onTapEdit,
      this.isInEditMode,
      this.onTapDelete,
      this.index});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;

    String startDate = experienceInfoModel.startDate != null
        ? "${DateFormatUtil().dateFormat1(experienceInfoModel.startDate)} "
        : "";
    String date = "$startDate"
        "- ${experienceInfoModel.endDate == null ? "Ongoing" : DateFormatUtil().dateFormat1(experienceInfoModel.endDate)}";

    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: CommonStyle.boxShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          CachedNetworkImage(
            height: 55,
            width: 55,
            fit: BoxFit.cover,
            placeholder: (context, _) => Image.asset(
              kCompanyImagePlaceholder,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            imageUrl: experienceInfoModel.companyProfilePic ?? "",
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experienceInfoModel.companyName ?? "",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(experienceInfoModel.designation ?? ""),
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
                  key: Key('experienceEditButton'+index.toString()),
                  onPressed: onTapEdit,
                  iconSize: 18,
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.trash),
                  key: Key('experienceDeleteButton'+index.toString()),
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
