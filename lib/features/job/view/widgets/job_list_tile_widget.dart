import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';

class JobListTileWidget extends StatefulWidget {
  final JobModel jobModel;
  final Function onTap;

  JobListTileWidget(this.jobModel, {this.onTap});

  @override
  _JobListTileWidgetState createState() => _JobListTileWidgetState();
}

class _JobListTileWidgetState extends State<JobListTileWidget> {
  bool heart;

  @override
  Widget build(BuildContext context) {
    String publishDateText = widget.jobModel.createdDate == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil()
            .dateFormat1(DateTime.parse(widget.jobModel.createdDate));
    String deadLineText = widget.jobModel.applicationDeadline == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil()
            .dateFormat1(DateTime.parse(widget.jobModel.applicationDeadline));

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
      child:Image.asset(kImagePlaceHolderAsset),
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
              widget.jobModel.jobLocation ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: subtitleColor),
            ),
          )
        ],
      ),
    );
    var heartButton = InkWell(
      onTap: () {
        if (heart == false) {
          heart = true;
        } else {
          heart = false;
        }
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          heart == true? FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
          color: heart == true ? AppTheme.orange : AppTheme.grey,
          size: 22,
        ),
      ),
    );
    var applyButton = Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          gradient: AppTheme.defaultLinearGradient,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          StringUtils.applyText,
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
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
    var publishDateWidget = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.clock,
          size: iconSize,
          color: subtitleColor
        ),
        SizedBox(width: 5),
        Text(
          deadLineText,
          style: TextStyle(color: subtitleColor,fontWeight: FontWeight.w100),
        ),
      ],
    );
    var deadLineWidget = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.calendar,
          size: iconSize,
          color: subtitleColor,
        ),
        SizedBox(width: 5),
        Text(
          publishDateText,
          style: TextStyle(color: subtitleColor,fontWeight: FontWeight.w100),
        ),
      ],
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => JobDetails(
                  jobModel: widget.jobModel,
                )));
      },
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
                      companyLocation,
                    ],
                  )),
                  SizedBox(width: 8),
                  heartButton,
                ],
              ),
            ),
            //Job Title
            SizedBox(
              height: 4
            ),
            Container(
              padding: EdgeInsets.all(8),
              color: backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  deadLineWidget,
                  publishDateWidget,
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