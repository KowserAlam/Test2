import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/util/app_theme.dart';
import 'package:p7app/main_app/util/const.dart';
import 'package:p7app/main_app/util/strings_utils.dart';

class JobListItemWidget extends StatefulWidget {
  final JobModel jobModel;
  final Function onTap;

  JobListItemWidget(this.jobModel, {this.onTap});

  @override
  _JobListItemWidgetState createState() => _JobListItemWidgetState();
}

class _JobListItemWidgetState extends State<JobListItemWidget> {
  bool heart;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    double iconSize = 14.0;
    bool isTabLayout = MediaQuery.of(context).size.width > kMidDeviceScreenSize;
    var subtitleColor = AppTheme.grey;

    var companyLogo = Container(

      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
        border: Border.all(color: AppTheme.grey.withOpacity(0.5))
      ),

      child: Center(
        child: FaIcon(
          FontAwesomeIcons.atom,
          size: 50,
          color: Colors.purpleAccent,
        ),
      ),
    ); //That pointless fruit logo
    var jobTitle = Text(
      widget.jobModel.title,
      style: titleStyle,
    );
    var companyName = Row(
      children: <Widget>[
        Icon(
          FeatherIcons.briefcase,
          color: subtitleColor,
          size: iconSize,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            widget.jobModel.companyName,
            style: TextStyle(color: subtitleColor),
          ),
        )
      ],
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
          Text(
            widget.jobModel.jobLocation,
            style: TextStyle(color: subtitleColor),
          )
        ],
      ),
    );
    var heartButton = GestureDetector(
      onTap: () {
        if (heart == false) {
          heart = true;
        } else {
          heart = false;
        }
        setState(() {});
      },
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:  Border.all(color: heart == true ? AppTheme.orange:AppTheme.grey),
          shape: BoxShape.circle,
          color: scaffoldBackgroundColor,
        ),
        child: Icon(FeatherIcons.heart,
            color: heart == true ? AppTheme.orange : AppTheme.grey,size: 22,),
      ),
    );
    var applyButton = Container(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          gradient: AppTheme.defaultLinearGradient,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          StringUtils.applyText,
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
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
    var deadLine = Row(
      children: <Widget>[
        Text(
          "${StringUtils.deadlineText}: ",
        ),
        Text(
          widget.jobModel.applicationDeadline != null
              ? widget.jobModel.applicationDeadline
              : StringUtils.unspecifiedText,
        ),
      ],
    );
    return Container(
      color:backgroundColor,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: isTabLayout?Row(
        children: <Widget>[
          companyLogo,
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Job Title
                jobTitle,
                SizedBox(
                  height: 10
                ),
                Row(
                  children: <Widget>[
                    Expanded(flex:3,child: companyName),
                    Expanded(flex:2,child: companyLocation),
                  ],
                ),
                SizedBox(height: 3),

                SizedBox(height: 3),
                jobType,



              ],
            ),
          ),
          Column(children: <Widget>[
            //Job Title
            Row(
              children: <Widget>[
                heartButton,
                SizedBox(width: 20,),
                applyButton,
              ],
            ),
            SizedBox(height: 8,),
            deadLine
          ],),
        ],
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyLogo,
          //Job Title
          jobTitle,
          SizedBox(
            height: 10,
          ),
          companyName,
          SizedBox(height: 3),
          companyLocation,
          SizedBox(height: 3),
          jobType,
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              heartButton,
              SizedBox(width: 20,),
              applyButton,
            ],
          ),
          SizedBox(height: 8,),
          deadLine,
        ],
      )
      ,
    );
  }
}
