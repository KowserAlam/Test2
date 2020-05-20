import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_model.dart';

import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/features/job/view/widgets/job_apply_button.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:p7app/main_app/util/method_extension.dart';

enum JobListScreenType { main, applied, favorite }

class JobDetails extends StatefulWidget {
  final String slug;
  final JobListScreenType fromJobListScreenType;

  JobDetails({@required this.slug, this.fromJobListScreenType});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  JobModel jobDetails;

  @override
  void initState() {
    // TODO: implement initState
//    getDetails();
    print(widget.slug);
    getJobDetails();
    super.initState();
  }

  _refreshList() {
    Provider.of<JobListViewModel>(context, listen: false).refresh();
    if (widget.fromJobListScreenType != null) {
      switch (widget.fromJobListScreenType) {
        case JobListScreenType.main:
          break;
        case JobListScreenType.applied:
          Provider.of<AppliedJobListViewModel>(context, listen: false)
              .refresh();
          break;
        case JobListScreenType.favorite:
          Provider.of<FavouriteJobListViewModel>(context, listen: false)
              .refresh();
          break;
      }
    }
  }

  Future<bool> addToFavorite(
    String jobId,
  ) async {
    bool res = await JobRepository().addToFavorite(jobId);
    _refreshList();
    return res;
  }

  Future<bool> applyForJob(
    String jobId,
  ) async {
    bool res = await JobRepository().applyForJob(jobId);
    _refreshList();
    return res;
  }

  _showApplyDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(StringUtils.doYouWantToApplyText),
            actions: [
              RawMaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(StringUtils.noText),
              ),
              RawMaterialButton(
                onPressed: () {
                  applyForJob(jobDetails.jobId).then((value) {
                    setState(() {
                      jobDetails.isApplied = value;
                    });
                  });
                  Navigator.pop(context);
                },
                child: Text(StringUtils.yesText),
              ),
            ],
          );
        });
  }

  String skillListToString() {
    var listOfSkills = "";
    for (int i = 0; i < jobDetails.skill.length; i++) {
      if (i + 1 == jobDetails.skill.length) {
        listOfSkills += jobDetails.skill[i];
      } else {
        listOfSkills += jobDetails.skill[i] + ", ";
      }
    }
    return listOfSkills;
  }

  getJobDetails() async {
    dartZ.Either<AppError, JobModel> result =
        await JobRepository().fetchJobDetails(widget.slug);
    return result.fold((l) {
      print(l);
    }, (JobModel dataModel) {
      print(dataModel.title);
      jobDetails = dataModel;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
//    var jobDetailViewModel = Provider.of<JobDetailViewModel>(context);

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color sectionColor = Theme.of(context).backgroundColor;
    Color summerySectionBorderColor = Colors.grey[300];
    Color summerySectionColor =
        !isDarkMode ? Colors.grey[200] : Colors.grey[600];
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];

    //Styles
    TextStyle headerTextStyle =
        new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle sectionTitleFont =
        TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    TextStyle descriptionFontStyle = TextStyle(fontSize: 13);
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
    TextStyle descriptionFontStyleBold =
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    double fontAwesomeIconSize = 15;

    Text jobSummeryRichText(String title, String description) {
      return Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(text: title, style: descriptionFontStyleBold),
          TextSpan(text: ': ', style: descriptionFontStyleBold),
          TextSpan(text: description, style: descriptionFontStyle),
        ]),
        style: descriptionFontStyle,
      );
    }

    if (jobDetails == null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(
            StringUtils.jobDetailsAppBarTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Loader(),
        ),
      );
    }

    double iconSize = 14;
    double sectionIconSize = 20;
    Color clockIconColor = Colors.orange;

    bool isFavorite = jobDetails?.isFavourite ?? false;
    bool isApplied = jobDetails?.isApplied ?? false;
//    bool isDateExpired = jobDetails.applicationDeadline != null
//        ? DateTime.now().isAfter(jobDetails.applicationDeadline)
//        : true;

    //Widgets
    var heartButton = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          addToFavorite(jobDetails.jobId).then((value) {
            if (value) {
              jobDetails.isFavourite = !jobDetails.isFavourite;
            }

            setState(() {});
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: isFavorite ? AppTheme.orange : AppTheme.grey,
            size: 22,
          ),
        ),
      ),
    );
    var applyButtonOld = Material(
      color: isApplied ? Colors.grey : Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: isApplied
            ? null
            : () {
                _showApplyDialog();
              },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 30,
          width: 65,
          alignment: Alignment.center,
//          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),

          child: Text(
            isApplied ? StringUtils.appliedText : StringUtils.applyText,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
    var applyButton = JobApplyButton(
      isApplied: isApplied,
      applicationDeadline: jobDetails.applicationDeadline,
      onPressedApply: () {
        _showApplyDialog();
      },
    );

    var spaceBetweenSections = SizedBox(
      height: 30,
    );
    var jobHeader = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[300])),
            margin: EdgeInsets.only(right: 10),
            child: CachedNetworkImage(
              placeholder: (context, _) => Image.asset(
                kCompanyImagePlaceholder,
                fit: BoxFit.cover,
              ),
              imageUrl: jobDetails.profilePicture ?? "",
            ),
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
                      child: Container(
                        child: Text(
                          jobDetails.title != null
                              ? jobDetails.title
                              : StringUtils.unspecifiedText,
                          style: headerTextStyle,
                        ),
                      ),
                    ),
                    heartButton,
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      jobDetails.companyName != null
                          ? jobDetails.companyName
                          : StringUtils.unspecifiedText,
                      style: topSideDescriptionFontStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
//                    if (jobDetails.jobCity.isNotEmptyOrNotNull)
//                      Row(
//                        children: <Widget>[
//                          Icon(
//                            FeatherIcons.mapPin,
//                            size: iconSize,
//                          ),
//                          SizedBox(
//                            width: 5,
//                          ),
//                          Flexible(
//                            child: Text(
//                            jobDetails.jobCity
//                                  ?? StringUtils.unspecifiedText,
//                              style: topSideDescriptionFontStyle,
//                            ),
//                          )
//                        ],
//                      )
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
              Transform.rotate(
                  angle: pi,
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: FaIcon(
                        FontAwesomeIcons.alignLeft,
                        size: fontAwesomeIconSize,
                      ))),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.jobDescriptionTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.descriptions != null
                ? jobDetails.descriptions
                : StringUtils.unspecifiedText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
    var responsibilities = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.bolt,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.responsibilitiesTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.responsibilities != null
                ? jobDetails.responsibilities
                : StringUtils.unspecifiedText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
    var education = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.book,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.educationTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.education != null
                ? jobDetails.education
                : StringUtils.unspecifiedText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );

    var additionalRequirements = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                StringUtils.jobAdditionalRequirementsText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.additionalRequirements != null
                ? jobDetails.additionalRequirements
                : StringUtils.unspecifiedText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );

    var location = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                Icons.pin_drop,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.jobLocation,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobAddressText,
              jobDetails.jobAddress != null
                  ? jobDetails.jobAddress
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobAreaText,
              jobDetails.jobArea != null
                  ? jobDetails.jobArea
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobCityText,
              jobDetails.jobCity != null
                  ? jobDetails.jobCity
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobCountryText,
              jobDetails.jobCountry != null
                  ? jobDetails.jobCountry
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    var aboutJob = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.exclamationCircle,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.jobAboutText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobTypeText,
              jobDetails.jobType != null
                  ? StringExtenion(jobDetails.jobType).titleCase
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobNature,
              jobDetails.jobNature != null
                  ? StringExtenion(jobDetails.jobNature).titleCase
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
              StringUtils.jobSiteText,
              jobDetails.jobSite != null
                  ? StringExtenion(jobDetails.jobSite).titleCase
                  : StringUtils.unspecifiedText),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
    var aboutCompany = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.solidBuilding,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.jobAboutCompanyText,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(StringUtils.jobCompanyProfileText+': ', style: descriptionFontStyleBold,),
              jobDetails.companyProfile!=null?GestureDetector(
                  onTap: (){
                    UrlLauncherHelper.launchUrl(jobDetails.companyProfile.trim());
                  },
                  child: Text(jobDetails.companyProfile, style: TextStyle(color: Colors.lightBlue),)):Text(StringUtils.unspecifiedText),
            ],
          ),
          SizedBox(
            height: 5,
          ),
//          jobSummeryRichText(StringUtils.jobNature, jobDetails.jobNature!=null?jobDetails.jobNature:StringUtils.unspecifiedText),
//          SizedBox(height: 5,),
        ],
      ),
    );
    var salary = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.moneyBillWave,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.salaryTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          jobSummeryRichText(
            StringUtils.currentOffer,
            jobDetails.salary != null
                ? jobDetails.salary.toString() +
                    ' ' +
                    (jobDetails.currency != null ? jobDetails.currency : '')
                : StringUtils.unspecifiedText,
          ),
          jobSummeryRichText(
            StringUtils.salaryRangeText,
            (jobDetails.salaryMin != null
                    ? jobDetails.salaryMin.toString()
                    : StringUtils.unspecifiedText) +
                "-" +
                (jobDetails.salaryMax != null
                    ? jobDetails.salaryMax.toString() +
                        ' ' +
                        (jobDetails.currency != null ? jobDetails.currency : '')
                    : StringUtils.unspecifiedText),
          )
        ],
      ),
    );
    var otherBenefits = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.gift,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.otherBenefitsTitle,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            jobDetails.otherBenefits != null
                ? jobDetails.otherBenefits
                : StringUtils.unspecifiedText,
            style: descriptionFontStyle,
          )
        ],
      ),
    );
    var jobSummary = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.list),
            Text(
              StringUtils.jobSummeryTitle,
              style: sectionTitleFont,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              //gradient: isDarkMode?AppTheme.darkLinearGradient:AppTheme.lightLinearGradient,
              border: Border.all(width: 1, color: summerySectionBorderColor),
              color: summerySectionColor),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringUtils.category,
                      jobDetails.jobCategory != null
                          ? jobDetails.jobCategory
                          : StringUtils.unspecifiedText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringUtils.vacancy,
                      jobDetails.vacancy != null
                          ? jobDetails.vacancy.toString()
                          : StringUtils.unspecifiedText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringUtils.qualificationText,
                      jobDetails.qualification != null
                          ? jobDetails.qualification
                          : StringUtils.unspecifiedText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringUtils.gender,
                      jobDetails.gender != null
                          ? jobDetails.gender
                          : StringUtils.unspecifiedText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  jobSummeryRichText(
                      StringUtils.experience,
                      jobDetails.experience != null
                          ? jobDetails.experience
                          : StringUtils.unspecifiedText)
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        )
      ],
    );
    var requiredSkills = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.tools,
                size: fontAwesomeIconSize,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringUtils.requiredSkills,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            skillListToString(),
            style: descriptionFontStyle,
          )
        ],
      ),
    );

    var benefits = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        salary,
        spaceBetweenSections,
        otherBenefits
      ],
    );

    var benefitsHeader = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              StringUtils.benefitSectionTitle,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );

    var betweenDividerSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(FeatherIcons.calendar, size: 14, color: Colors.grey[500]),
            SizedBox(
              width: 5,
            ),
            Text(
              jobDetails.postDate != null
                  ? DateFormatUtil.formatDate(jobDetails.postDate)
                  : StringUtils.unspecifiedText,
              style: topSideDescriptionFontStyle,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FeatherIcons.clock,
              size: 14,
              color: Colors.grey[500],
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              jobDetails.applicationDeadline != null
                  ? DateFormatUtil.formatDate(jobDetails.applicationDeadline)
                  : StringUtils.unspecifiedText,
              style: topSideDescriptionFontStyle,
            ),
          ],
        ),
        applyButton,
      ],
    );

    var jobSource = Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () {
                  launch(jobDetails.webAddress);
                },
                child: Text(
                  StringUtils.jobSource,
                  style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                ))
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(
          StringUtils.jobDetailsAppBarTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color: backgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      jobHeader,
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      betweenDividerSection,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      jobSummary,
                      spaceBetweenSections,
                      aboutJob,
                      spaceBetweenSections,
                      description,
                      spaceBetweenSections,
                      responsibilities,
                      spaceBetweenSections,
                      requiredSkills,
                      spaceBetweenSections,
                      education,
                      spaceBetweenSections,
                      additionalRequirements,
                      spaceBetweenSections,
                      location,
                      spaceBetweenSections,
                      aboutCompany,
                      spaceBetweenSections,
                      benefitsHeader,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      benefits,
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sectionColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      betweenDividerSection,
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                jobDetails.webAddress != null
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: sectionColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(3),
                              bottomRight: Radius.circular(3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[jobSource],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
