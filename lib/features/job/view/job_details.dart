import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/decorations.dart';
import 'package:p7app/main_app/widgets/custom_Button.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';

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
    TextStyle sectionTitleFont = TextStyle(fontSize: 17,);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 12,);
    TextStyle descriptionFontStyleBold = TextStyle(fontSize: 12,fontWeight: FontWeight.bold);
    TextStyle appbarTextStyle = TextStyle();


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
            width: width*0.25,
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.grey[300])
            ),
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(kIshraakIcon, fit: BoxFit.cover,),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.jobModel.title != null
                    ? widget.jobModel.title
                    : StringUtils.unspecifiedText, style: headerTextStyle,),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          FeatherIcons.briefcase,
                          size: iconSize,
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: Text(widget.jobModel.companyName != null
                              ? widget.jobModel.companyName
                              : StringUtils.unspecifiedText, style: descriptionFontStyle,),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.clock,
                          size: iconSize,
                          color: clockIconColor,
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: Text(widget.jobModel.employmentStatus != null
                              ? widget.jobModel.employmentStatus
                              : StringUtils.unspecifiedText, style: descriptionFontStyle,),
                        )
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(
                          FeatherIcons.mapPin,
                          size: iconSize,
                        ),
                        SizedBox(width: 5,),
                        Flexible(
                          child: Text(widget.jobModel.jobLocation != null
                              ? widget.jobModel.jobLocation
                              : StringUtils.unspecifiedText, style: descriptionFontStyle,),
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
    var dividerUpperSideButtons = Row(
      children: <Widget>[
        GreyToWhiteButtonWithIcon(height: 55,width: 135,text: StringUtils.saveJobButtonText,iconData: FontAwesomeIcons.heart,),
        SizedBox(width: 30,),
        BlueButton(height: 55,width: 135,text: StringUtils.applyButtonText,),
      ],
    );
    var dividerLowerSideButtons = Row(
      children: <Widget>[
        BlueButton(height: 55,width: 135,text: 'Apply Online',),
        SizedBox(width: 30,),
        GreyToWhiteButtonWithIcon(height: 55,width: 135,text: 'Email Job',iconData: Icons.email,)
      ],
    );
    var description = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.description,size: sectionIconSize,),
              SizedBox(width: 5,),
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
              Icon(FontAwesomeIcons.bolt,size: sectionIconSize,),
              SizedBox(width: 5,),
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
              Icon(FontAwesomeIcons.book,size: sectionIconSize,),
              SizedBox(width: 5,),
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
              Icon(FontAwesomeIcons.moneyBillWave,size: sectionIconSize,),
              SizedBox(width: 10,),
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
              Icon(FontAwesomeIcons.gift,size: sectionIconSize,),
              SizedBox(width: 5,),
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
        gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(StringUtils.jobSummeryTitle,style: sectionTitleFont,),
          Divider(height: 15,),
          Row(
            children: <Widget>[
              Text.rich(
                TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.publishedOn, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.createdDate != null
                    ? widget.jobModel.createdDate
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),style: descriptionFontStyle,)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.vacancy, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.vacancy != null
                    ? widget.jobModel.vacancy.toString()
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.employmentStatus, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.employmentStatus != null
                    ? widget.jobModel.employmentStatus
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.yearsOfExperience, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.experience != null
                    ? widget.jobModel.experience
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.jobLocation, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.jobLocation != null
                    ? widget.jobModel.jobLocation
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.salary, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.salary != null
                    ? widget.jobModel.salary.toString()
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.gender, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.gender != null
                    ? widget.jobModel.gender
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: <Widget>[
              RichText(text: TextSpan(children: <TextSpan>[
                TextSpan(text: StringUtils.applicationDeadline, style: descriptionFontStyleBold),
                TextSpan(text: widget.jobModel.applicationDeadline != null
                    ? widget.jobModel.applicationDeadline
                    : StringUtils.unspecifiedText, style: descriptionFontStyle),
              ]),)
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


    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          height: AppBar().preferredSize.height,
          child: Row(
            children: <Widget>[
              Image.asset(kDefaultLogo,fit: BoxFit.cover,),
              Text(StringUtils.jobDetailsAppBarTitle),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                dividerUpperSide,
                SizedBox(height: 20,),
                dividerUpperSideButtons,
                Divider(height: 40,),
                description,
                spaceBetweenSections,
                responsibilities,
                spaceBetweenSections,
                education,
                spaceBetweenSections,
                salary,
                spaceBetweenSections,
                otherBenefits,
                spaceBetweenSections,
                dividerLowerSideButtons,
                spaceBetweenSections,
                jobSummery,
                spaceBetweenSections,
                requiredSkills
              ],
            ),
          ),
        ],
      ),
    );
  }
}
