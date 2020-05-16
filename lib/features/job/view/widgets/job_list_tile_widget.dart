import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

import 'job_apply_button.dart';

class JobListTileWidget extends StatefulWidget {
  final JobListModel jobModel;
  final Function onTap;
  final Function onApply;
  final Function onFavorite;

  JobListTileWidget(this.jobModel, {this.onTap, this.onFavorite, this.onApply});

  @override
  _JobListTileWidgetState createState() => _JobListTileWidgetState();
}

class _JobListTileWidgetState extends State<JobListTileWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.jobModel.isFavourite;

    String publishDateText = widget.jobModel.postDate == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobModel.postDate);

    String deadLineText = widget.jobModel.applicationDeadline == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobModel.applicationDeadline);
//    bool isDateExpired = widget.jobModel.applicationDeadline != null
//        ? DateTime.now().isAfter(widget.jobModel.applicationDeadline)
//        : true;

//    debugPrint("Deadline: ${widget.jobModel.applicationDeadline}\n Today: ${DateTime.now()} \n $isDateExpired");

    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
//    bool isTabLayout = MediaQuery.of(context).size.width > kMidDeviceScreenSize;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var companyLogo = Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
      ),
      child: CachedNetworkImage(
        imageUrl: widget.jobModel.profilePicture ?? "",
        placeholder: (context, _) => Image.asset(kCompanyImagePlaceholder),
      ),
    ); //That pointless fruit logo
    var jobTitle = Text(
      widget.jobModel.title ?? "",
      style: titleStyle,
    );
    var companyName = Text(
      widget.jobModel.companyName ?? "",
      style: TextStyle(color: subtitleColor),
    );
    var companyLocation = Container(
      child: Row(
        children: <Widget>[
          Icon(
            FeatherIcons.mapPin,
            color: subtitleColor,
            size: iconSize,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              widget.jobModel.jobCity ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: subtitleColor),
            ),
          )
        ],
      ),
    );
    var heartButton = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: widget.onFavorite,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: isFavorite ? AppTheme.orange : AppTheme.grey,
            size: 22,
          ),
        ),
      ),
    );


    var applyButton = JobApplyButton(
      applicationDeadline: widget.jobModel.applicationDeadline,
      onPressedApply: widget.onApply,
      isApplied: widget.jobModel.isApplied,
    );
    var jobType = Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.clock,
          size: iconSize,
          color: AppTheme.orange,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          widget.jobModel.employmentStatus != null
              ? widget.jobModel.employmentStatus
              : StringUtils.unspecifiedText,
          style: TextStyle(color: subtitleColor),
        ),
      ],
    );
    var applicationDeadlineWidget = Row(
      children: <Widget>[
        Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
        SizedBox(width: 5),
        Text(
          deadLineText,
          style: TextStyle(color: subtitleColor, fontWeight: FontWeight.w100),
        ),
      ],
    );
    var publishDate = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.calendar,
          size: iconSize,
          color: subtitleColor,
        ),
        SizedBox(width: 5),
        Text(
          publishDateText,
          style: TextStyle(color: subtitleColor, fontWeight: FontWeight.w100),
        ),
      ],
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(color: scaffoldBackgroundColor,
//        borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
            ]),
        margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: backgroundColor,
              padding: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  companyLogo,
                  SizedBox(width: 8),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      jobTitle,
                      SizedBox(height: 3),
                      companyName,
                      SizedBox(height: 3),
                      if (widget.jobModel.jobCity != null) companyLocation,
                    ],
                  )),
                  SizedBox(width: 8),
                  heartButton,
                ],
              ),
            ),
            //Job Title
            SizedBox(height: 1),
            Container(
              padding: EdgeInsets.all(8),
              color: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  publishDate,
                  applicationDeadlineWidget,
                  applyButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
