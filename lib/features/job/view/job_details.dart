import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/decorations.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/widgets/custom_Button.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/gredient_buton.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatefulWidget {
  final JobModel jobModel;
  JobDetails({@required this.jobModel});
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //Styles
    TextStyle headerTextStyle = new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sectionTitleFont = TextStyle(fontSize: 17,fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle topSideDescriptionFontStyle = TextStyle(fontSize: 15,color: Colors.grey[600]);
    TextStyle descriptionFontStyleBold = TextStyle(fontSize: 12,fontWeight: FontWeight.bold);

    Text jobSummeryRichText(String title, String description){
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: description, style: descriptionFontStyle),
        ]),style: descriptionFontStyle,);
    }


    double iconSize = 14;
    double sectionIconSize = 20;
    Color clockIconColor = Colors.orange;

    //Widgets
    var spaceBetweenSections = SizedBox(height: 30,);
    var dividerUpperSide = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey[300])
            ),
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(kImagePlaceHolderAsset, fit: BoxFit.cover,),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(child: Text(widget.jobModel.title != null
                          ? widget.jobModel.title
                          : StringUtils.unspecifiedText, style: headerTextStyle,),),
                    ),
                    FaIcon(FontAwesomeIcons.heart,size: 18,)
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.jobModel.companyName != null
                        ? widget.jobModel.companyName
                        : StringUtils.unspecifiedText, style: topSideDescriptionFontStyle,),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(
                          FeatherIcons.mapPin,
                          size: iconSize,
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: Text(widget.jobModel.division != null
                              ? widget.jobModel.division
                              : StringUtils.unspecifiedText, style: topSideDescriptionFontStyle,),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    var description = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtils.jobDescriptionTitle, style: sectionTitleFont,)
            ],
          ),
          SizedBox(height: 5,),
          Text(widget.jobModel.descriptions != null
              ? widget.jobModel.descriptions
              : StringUtils.unspecifiedText, style: descriptionFontStyle,)
        ],
      ),
    );
    var responsibilities = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtils.responsibilitiesTitle, style: sectionTitleFont,)
            ],
          ),
          SizedBox(height: 5,),
          Text(widget.jobModel.responsibilities != null
              ? widget.jobModel.responsibilities
              : StringUtils.unspecifiedText, style: descriptionFontStyle,)
        ],
      ),
    );
    var education = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtils.educationTitle, style: sectionTitleFont,)
            ],
          ),
          SizedBox(height: 5,),
          Text(widget.jobModel.education != null
              ? widget.jobModel.education
              : StringUtils.unspecifiedText, style: descriptionFontStyle,)
        ],
      ),
    );
    var salary = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtils.salaryTitle, style: sectionTitleFont,)
            ],
          ),
          SizedBox(height: 5,),
          Text(widget.jobModel.salary != null
              ? widget.jobModel.salary.toString()
              : StringUtils.unspecifiedText, style: descriptionFontStyle,)
        ],
      ),
    );
    var otherBenefits = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(StringUtils.otherBenefitsTitle, style: sectionTitleFont,)
            ],
          ),
          SizedBox(height: 5,),
          Text(widget.jobModel.otherBenefits != null
              ? widget.jobModel.otherBenefits
              : StringUtils.unspecifiedText, style: descriptionFontStyle,)
        ],
      ),
    );
    var jobSummery = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient,
        border: Border.all(width: 1, color: Colors.grey[300])
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.event_note, color: Colors.black,),
              Text(StringUtils.jobSummeryTitle,style: sectionTitleFont,),
            ],
          ),
          Divider(height: 15,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.publishedOn, widget.jobModel.createdDate != null
                  ? widget.jobModel.createdDate.toString():StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.vacancy, widget.jobModel.vacancy != null
                  ? widget.jobModel.vacancy.toString()
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.employmentStatus, widget.jobModel.employmentStatus != null
                  ? widget.jobModel.employmentStatus
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.yearsOfExperience, widget.jobModel.experience != null
                  ? widget.jobModel.experience.toString()
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Container(child: jobSummeryRichText(StringUtils.jobLocation, widget.jobModel.jobLocation != null
              ? widget.jobModel.jobLocation.toString()
              : StringUtils.unspecifiedText),),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.salary, widget.jobModel.salary != null
                  ? widget.jobModel.salary.toString()
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.gender, widget.jobModel.gender != null
                  ? widget.jobModel.gender.toString()
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              jobSummeryRichText(StringUtils.applicationDeadline, widget.jobModel.applicationDeadline != null
                  ? widget.jobModel.applicationDeadline.toString()
                  : StringUtils.unspecifiedText)
            ],
          ),
          SizedBox(height: 5,),
        ],
      ),
    );
    var requiredSkills = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(StringUtils.requiredSkills, style: sectionTitleFont,),
          SizedBox(height: 5,),
        ],
      ),
    );

    var benefits = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text(StringUtils.benefits, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)],),
        Divider(height: 20,),
        salary,
        spaceBetweenSections,
        otherBenefits
      ],
    );

    var betweenDividerSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
                FeatherIcons.clock,
                size: 14,
                color: Colors.grey[500]
            ),
            SizedBox(width: 5,),
            Text(widget.jobModel.createdDate != null
                ? DateFormatUtil()
                .dateFormat1(DateTime.parse(widget.jobModel.createdDate))
                : StringUtils.unspecifiedText, style: topSideDescriptionFontStyle,),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FeatherIcons.calendar,
              size: 14,
              color: Colors.grey[500],
            ),
            SizedBox(width: 5,),
            Text(widget.jobModel.applicationDeadline != null
                ? DateFormatUtil()
                .dateFormat1(DateTime.parse(widget.jobModel.applicationDeadline))
                : StringUtils.unspecifiedText, style: topSideDescriptionFontStyle,),
          ],
        ),
        Container(
          height: 35,
          width: 95,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              StringUtils.applyButtonText,
              style: TextStyle(
                  fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );

    var jobSource = Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: (){
                  launch(widget.jobModel.webAddress);
                },
                child: Text(StringUtils.jobSource, style: TextStyle(fontSize: 15,color: Colors.blueAccent),))
          ],
        ),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(StringUtils.jobDetailsAppBarTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                dividerUpperSide,
                Divider(height: 20,),
                betweenDividerSection,
                Divider(height: 20,),
                jobSummery,
                spaceBetweenSections,
                description,
                spaceBetweenSections,
                responsibilities,
                spaceBetweenSections,
                requiredSkills,
                spaceBetweenSections,
                education,
                spaceBetweenSections,
                benefits,
                Divider(height: 20,),
                betweenDividerSection,
                Divider(height: 20,),
                widget.jobModel.webAddress!=null?jobSource:null
              ],
            ),
          ),
        ],
      ),
    );
  }
}
