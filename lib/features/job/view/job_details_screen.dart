import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart' as dartZ;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/company/view/company_details.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/features/job/view/widgets/job_apply_button.dart';
import 'package:p7app/features/job/view/widgets/share_job_on_social_media_widget.dart';
import 'package:p7app/features/job/view/widgets/simelar_jobs_widget.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/all_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_details_view_model.dart';
import 'package:p7app/main_app/api_helpers/url_launcher_helper.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:p7app/main_app/views/widgets/page_state_builder.dart';
import 'package:p7app/method_extension.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum JobListScreenType { main, applied, favorite }

class JobDetailsScreen extends StatefulWidget {
  final String slug;
  final JobListScreenType fromJobListScreenType;
  final Function onApply;
  final Function onFavourite;

  JobDetailsScreen(
      {@required this.slug,
      this.fromJobListScreenType,
      this.onApply,
      this.onFavourite}) {
    Get.put(JobDetailsViewModel(), tag: slug);
  }

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState(this.slug);
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  var salaryFormat = NumberFormat.simpleCurrency(decimalDigits: 0, name: "");
  JobDetailsViewModel vm;
  final bool isDarkMode = Theme.of(Get.context).brightness == Brightness.dark;
  final Color sectionColor = Theme.of(Get.context).backgroundColor;
  final Color summerySectionBorderColor = Colors.grey[300];

  //Styles
  TextStyle headerTextStyle =
      new TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle sectionTitleFont =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  TextStyle descriptionFontStyle = TextStyle(fontSize: 13);

  TextStyle hasCompanyFontStyle =
      TextStyle(fontSize: 14, color: Colors.blueAccent);
  TextStyle descriptionFontStyleBold =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  double fontAwesomeIconSize = 15;
  double iconSize = 14;
  double sectionIconSize = 20;
  Color clockIconColor = Colors.orange;
  Widget spaceBetweenSections = SizedBox(height: 30);

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

  _JobDetailsScreenState(String slug) {
    this.vm = Get.find<JobDetailsViewModel>(tag: slug);
  }

  @override
  void initState() {
    logger.i(widget.slug);
    vm.getJobDetails(widget.slug);
    super.initState();
  }

  Future<bool> addToFavorite(String jobId) async {
    bool res = await JobRepository().addToFavorite(jobId);
    if (widget.onFavourite != null) widget.onFavourite();
    return res;
  }



  _showLoginDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.signInRequiredText,
            content: Text(StringResources.doYouWantToSingInNowText),
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => SignInScreen()));
            },
          );
        });
  }



  String refactorAboutJobStrings(String value) {
    if (value == 'ONSITE') return 'On-site';
    if (value == 'Remote') return 'Remote';
    if (value == 'FULLTIME') return 'Full-time';
    if (value == 'PARTTIME') return 'Part-time';
    return value.toSentenceCase;
  }


  @override
  Widget build(BuildContext context) {
    bool isLoggerIn = Provider.of<AuthViewModel>(context).isLoggerIn;
    Color summerySectionColor =
        !isDarkMode ? Colors.grey[200] : Colors.grey[600];
    Color backgroundColor = !isDarkMode ? Colors.grey[200] : Colors.grey[700];
    TextStyle topSideDescriptionFontStyle = TextStyle(
        fontSize: 14, color: !isDarkMode ? Colors.grey[600] : Colors.grey[500]);
    return Obx(() {
      var jobDetails = vm.jobModel.value;
      bool isApplied = jobDetails?.isApplied ?? false;

      //Widgets
      Widget heartButton() {
        bool isFavorite = jobDetails?.isFavourite ?? false;
       return  ValueBuilder<bool>(
            initialValue: false,
            builder: (bool v,updateFn){
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: v? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Loader(),
                ):InkWell(
                  key: Key('jobDetailsFavoriteButton'),
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {

                    if (isLoggerIn){
                      updateFn(true);
                      addToFavorite(jobDetails.jobId).then((value) {
                        if (value) {
                          jobDetails.isFavourite = !jobDetails.isFavourite;
                          updateFn(false);
                        }

                      });
                    }

                    else
                      _showLoginDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: isFavorite ? AppTheme.colorPrimary : Colors.white,
                          size: 25,
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: isFavorite ? Colors.black : Colors.grey[600],
                          size: 25,
                        ),
                        Opacity(
                            opacity: 0.1,
                            child: Text(
                              isFavorite ? 'favorite' : 'notFavorite',
                              key: Key('checkJobFavorite'),
                              style: TextStyle(fontSize: 1),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            });

      }

      Widget applyButton = ValueBuilder<bool>(
          initialValue: isApplied,
          builder: (v,updateFn){
        return JobApplyButton(
          key: Key('jobDetailsApplyButton'),
          isApplied: v,
          applicationDeadline: jobDetails.applicationDeadline,
          onSuccessfulApply: () {
            updateFn(true);
            if(widget.onApply != null)
            widget.onApply();
            //
            // logger.i("Apply succesful");
            // vm.jobModel.value.isApplied = true;
            // vm.jobModel.value = vm.jobModel.value;

          }, jobId: jobDetails.jobId, jobTitle: jobDetails.title,
        );
      });


      Widget jobHeader = Container(
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
                imageUrl: jobDetails?.company?.profilePicture ?? "",
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
                                : StringResources.noneText,
                            style: headerTextStyle,
                            key: Key('jobDetailsJobTitle'),
                          ),
                        ),
                      ),
                      heartButton(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          jobDetails.company != null
                              ? jobDetails.company.name
                              : StringResources.noneText,
                          style: jobDetails.company == null
                              ? topSideDescriptionFontStyle
                              : hasCompanyFontStyle,
                          key: Key('jobDetailsCompanyName'),
                        ),
                        onTap: () {
                          if (jobDetails.company != null)
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => CompanyDetails(
                                          company: jobDetails.company,
                                        )));
                        },
                      ),
                      SizedBox(height: 5),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );

      Widget description() => (jobDetails.descriptions.isEmptyOrNull)
          ? SizedBox()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceBetweenSections,
                  Row(
                    children: <Widget>[
                      Transform.rotate(
                          angle: pi,
                          child: FaIcon(
                            FontAwesomeIcons.alignLeft,
                            size: fontAwesomeIconSize,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        StringResources.jobDescriptionTitle,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  HtmlWidget(
                    jobDetails.descriptions != null
                        ? jobDetails.descriptions
                        : StringResources.noneText,
                    textStyle: descriptionFontStyle,
                  )
                ],
              ),
            );
      Widget responsibilities() => (jobDetails.responsibilities.isEmptyOrNull)
          ? SizedBox()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceBetweenSections,
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
                        StringResources.responsibilitiesTitle,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  HtmlWidget(
                    jobDetails?.responsibilities ?? "",
                    textStyle: descriptionFontStyle,
                  ),
//          Text(
//            jobDetails?.responsibilities ?? "",
//            style: descriptionFontStyle,
//          )
                ],
              ),
            );
      Widget education() => (jobDetails.education.isEmptyOrNull)
          ? SizedBox()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceBetweenSections,
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
                        StringResources.educationTitle,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  HtmlWidget(
                    jobDetails.education != null
                        ? jobDetails.education
                        : StringResources.noneText,
                    textStyle: descriptionFontStyle,
                  )
                ],
              ),
            );

      Widget additionalRequirements() =>
          (jobDetails.additionalRequirements.isEmptyOrNull)
              ? SizedBox()
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      spaceBetweenSections,
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
                            StringResources.jobAdditionalRequirementsText,
                            style: sectionTitleFont,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HtmlWidget(
                        jobDetails?.additionalRequirements ?? "",
                        textStyle: descriptionFontStyle,
                      ),
                    ],
                  ),
                );



      Widget aboutJob() => (jobDetails.jobType.isEmptyOrNull &&
              jobDetails.jobSite.isEmptyOrNull &&
              jobDetails.jobNature.isEmptyOrNull)
          ? SizedBox()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceBetweenSections,
                  Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.exclamationCircle,
                        size: fontAwesomeIconSize,
                      ),
                      SizedBox(width: 5),
                      Text(
                        StringResources.jobAboutText,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  if (jobDetails.jobType.isNotEmptyOrNotNull)
                    jobSummeryRichText(StringResources.jobTypeText,
                        refactorAboutJobStrings(jobDetails.jobType)),
                  SizedBox(
                    height: 5,
                  ),
                  jobSummeryRichText(
                      StringResources.jobNature,
                      jobDetails.jobNature != null
                          ? refactorAboutJobStrings(jobDetails.jobNature)
                          : StringResources.noneText),
                  SizedBox(
                    height: 5,
                  ),
                  jobSummeryRichText(
                      StringResources.jobSiteText,
                      jobDetails.jobSite != null
                          ? refactorAboutJobStrings(jobDetails.jobSite)
                          : StringResources.noneText),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );

      Widget aboutCompany() => (jobDetails.companyProfile.isEmptyOrNull &&
              jobDetails?.company?.webAddress == null)
          ? SizedBox()
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  spaceBetweenSections,
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
                        StringResources.jobAboutCompanyText,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  HtmlWidget(
                    " <b>${StringResources.jobCompanyProfileText}</b>: ${jobDetails.companyProfile ?? ""}",
                    textStyle: descriptionFontStyle,
                  ),
                  // jobSummeryRichText(
                  //   StringResources.jobCompanyProfileText,
                  //   jobDetails.companyProfile,
                  // ),
//                Row(
//                  mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: [
//                    Text(
//                      StringResources.jobCompanyProfileText + ': ',
//                      style: descriptionFontStyleBold,
//                    ),
//                    jobDetails.companyProfile != null
//                        ? Text(
//                          jobDetails.companyProfile,
//                        )
//                        : Text(StringResources.noneText),
//                  ],
//                ),
                  SizedBox(
                    height: 5,
                  ),
                  if (jobDetails?.company?.webAddress?.isNotEmptyOrNotNull ??
                      false)
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: StringResources.companyWebAddressText + ': ',
                        style: descriptionFontStyleBold,
                      ),
                      WidgetSpan(
                          child: GestureDetector(
                              onTap: () {
                                if (jobDetails?.company?.webAddress != null)
                                  UrlLauncherHelper.launchUrl(
                                      jobDetails.companyProfile.trim());
                              },
                              child: Text(
                                jobDetails.company.webAddress ?? "",
                                style: TextStyle(color: Colors.lightBlue),
                              )))
                    ])),
                  // Row(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       StringResources.companyWebAddressText + ': ',
                  //       style: descriptionFontStyleBold,
                  //     ),
                  //     jobDetails.company != null
                  //         ? GestureDetector(
                  //             onTap: () {
                  //               jobDetails.company.webAddress != null
                  //                   ? UrlLauncherHelper.launchUrl(
                  //                       jobDetails.companyProfile.trim())
                  //                   : null;
                  //             },
                  //             child: Text(
                  //               jobDetails.company.webAddress ?? "",
                  //               style: TextStyle(color: Colors.lightBlue),
                  //             ))
                  //         : Text(StringResources.noneText),
                  //   ],
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            );

      Widget jobSummary() => (jobDetails.jobCategory.isEmptyOrNull &&
              jobDetails.vacancy != null &&
              jobDetails.qualification.isEmptyOrNull &&
              jobDetails.gender.isEmptyOrNull &&
              jobDetails.experience.isEmptyOrNull)
          ? SizedBox()
          : Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.list),
                    Text(
                      StringResources.jobSummeryTitle,
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
                      border: Border.all(
                          width: 1, color: summerySectionBorderColor),
                      color: summerySectionColor),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          jobSummeryRichText(
                              StringResources.category,
                              jobDetails.jobCategory != null
                                  ? jobDetails.jobCategory
                                  : StringResources.noneText)
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          jobSummeryRichText(
                              StringResources.vacancy,
                              jobDetails.vacancy != null
                                  ? "${jobDetails.vacancy == 0 ? StringResources.notSpecifiedText : jobDetails.vacancy}"
                                  : StringResources.noneText)
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          jobSummeryRichText(
                              StringResources.qualificationText,
                              jobDetails.qualification != null
                                  ? jobDetails.qualification
                                  : StringResources.noneText)
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          jobSummeryRichText(
                              StringResources.gender,
                              jobDetails.gender != null
                                  ? jobDetails.gender
                                  : StringResources.noneText)
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          jobSummeryRichText(
                              StringResources.experience,
                              jobDetails.experience != null
                                  ? jobDetails.experience
                                  : StringResources.noneText)
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



      bool hideSalary = (jobDetails.salary == null &&
          jobDetails.salaryMin == null &&
          jobDetails.salaryMax == null);
      Widget salary() => hideSalary
          ? SizedBox()
          : Container(
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
                        StringResources.salaryTitle,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  (jobDetails.salaryMin == null || jobDetails.salaryMax == null)
                      ? jobSummeryRichText(
                          StringResources.currentOffer,
                          StringResources.negotiableText,
                        )
                      : jobSummeryRichText(StringResources.salaryRangeText,
                          "${salaryFormat.format(jobDetails.salaryMin)} - ${salaryFormat.format(jobDetails.salaryMax)} "),

//                if (jobDetails.salaryMin.isEmptyOrNull &&
//                    jobDetails.salaryMax.isEmptyOrNull)
//                  jobSummeryRichText(
//                    StringResources.currentOffer,
//                    jobDetails.salary != null
//                        ? jobDetails.salary.toString() +
//                            ' ' +
//                            (jobDetails.currency != null
//                                ? jobDetails.currency
//                                : '')
//                        : StringResources.noneText,
//                  ),
//                if (jobDetails.salaryMin != null &&
//                    jobDetails.salaryMax != null)
//                  jobSummeryRichText(
//                    StringResources.salaryRangeText,
//                    (jobDetails.salaryMin != null
//                            ? jobDetails.salaryMin.toString()
//                            : StringResources.noneText) +
//                        "-" +
//                        (jobDetails.salaryMax != null
//                            ? jobDetails.salaryMax.toString() +
//                                ' ' +
//                                (jobDetails.currency != null
//                                    ? jobDetails.currency
//                                    : '')
//                            : StringResources.noneText),
//                  )
                ],
              ),
            );

      bool hideOtherBenefits = jobDetails.otherBenefits.isEmptyOrNull;
      Widget otherBenefits() => hideOtherBenefits
          ? SizedBox()
          : Container(
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
                        StringResources.otherBenefitsTitle,
                        style: sectionTitleFont,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  HtmlWidget(
                    jobDetails.otherBenefits != null
                        ? jobDetails.otherBenefits
                        : StringResources.noneText,
                    textStyle: descriptionFontStyle,
                  )
                ],
              ),
            );
      bool hideBenefits = hideSalary && hideOtherBenefits;
      Widget benefits() => hideBenefits
          ? SizedBox()
          : Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: sectionColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  salary(),
                  spaceBetweenSections,
                  otherBenefits(),
                  SizedBox(height: 5),
                ],
              ),
            );

      var benefitsHeader = hideBenefits
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                spaceBetweenSections,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      StringResources.benefitSectionTitle,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            );

      var betweenDividerSection = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          jobDetails.postDate == null
              ? SizedBox()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FeatherIcons.calendar,
                        size: 14, color: Colors.grey[500]),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      jobDetails.postDate != null
                          ? DateFormatUtil.formatDate(jobDetails.postDate)
                          : StringResources.noneText,
                      key: Key('jobDetailsPublishDate'),
                      style: topSideDescriptionFontStyle,
                    ),
                  ],
                ),
          jobDetails.applicationDeadline == null
              ? SizedBox()
              : Row(
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
                          ? DateFormatUtil.formatDate(
                              jobDetails.applicationDeadline)
                          : StringResources.noneText,
                      key: Key('jobDetailsDeadlineDate'),
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
                    StringResources.jobSource,
                    style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  ))
            ],
          ),
        ],
      );

      return Scaffold(
        appBar: AppBar(
          title: Text(
            StringResources.jobDetailsAppBarTitle,
            key: Key('jobDetailsAppbarTitle'),
          ),
          centerTitle: true,
          actions: [
            ShareJobOnSocialMediaWidget(
              jobDetails,
              key: Key("shareButtonKey"),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async => vm.getJobDetails(widget.slug),
          child: PageStateBuilder(
            appError: vm.appError.value,
            showError: vm.shouldShowAppError,
            showLoader: vm.shouldShowLoading,
            onRefresh: () async => vm.getJobDetails(widget.slug),
            child: ListView(
              key: Key('jobDetailsScrollKey'),
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
                            jobSummary(),
                            aboutJob(),
                            description(),
                            responsibilities(),
                            requiredSkills(jobDetails),
                            education(),
                            additionalRequirements(),
                            location(jobDetails),
                            aboutCompany(),
                            benefitsHeader,
                          ],
                        ),
                      ),
                      SizedBox(height: 2),
                      benefits(),
                      SizedBox(height: 2),
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
                      SizedBox(height: 2),
                      if (jobDetails.webAddress.isNotEmptyOrNotNull)
                        Container(
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
                        ),
                      SizedBox(height: 10),
                      SimilarJobsWidget(jobDetails),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget requiredSkills(JobModel jobDetails) {
    var skillsString = jobDetails?.jobSkills?.join(", ");

    return skillsString.isEmptyOrNull
        ? SizedBox()
        : Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          spaceBetweenSections,
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
                StringResources.requiredSkills,
                style: sectionTitleFont,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            skillsString??"",
            style: descriptionFontStyle,
          )
        ],
      ),
    );
  }
  Widget location(JobModel jobDetails) => (jobDetails.jobAddress.isEmptyOrNull &&
      jobDetails.jobArea.isEmptyOrNull &&
      jobDetails.jobCity.isEmptyOrNull &&
      jobDetails.jobCountry.isEmptyOrNull)
      ? SizedBox()
      : Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        spaceBetweenSections,
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
              StringResources.jobLocation,
              style: sectionTitleFont,
            )
          ],
        ),
        SizedBox(height: 5),
        jobSummeryRichText(
            StringResources.jobAddressText,
            jobDetails.jobAddress != null
                ? jobDetails.jobAddress
                : StringResources.noneText),
        SizedBox(
          height: 5,
        ),
        jobSummeryRichText(
            StringResources.jobAreaText,
            jobDetails.jobArea != null
                ? jobDetails.jobArea
                : StringResources.noneText),
        SizedBox(
          height: 5,
        ),
        jobSummeryRichText(
            StringResources.jobCityText,
            jobDetails.jobCity != null
                ? jobDetails.jobCity.swapValueByComa
                : StringResources.noneText),
        SizedBox(
          height: 5,
        ),
        (jobDetails.jobCountry.isEmptyOrNull)
            ? SizedBox()
            : jobSummeryRichText(StringResources.jobCountryText,
            jobDetails.jobCountry),
        SizedBox(
          height: 5,
        ),
      ],
    ),
  );
}
