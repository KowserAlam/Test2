import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:p7app/method_extension.dart';
import 'package:provider/provider.dart';

import 'job_apply_button.dart';

class JobListTileWidget extends StatelessWidget {
  final JobListModel jobModel;
  final Function onTap;
  final Function onApply;
  final Future Function() onFavorite;
  final int index;
  final Key listTileKey,
      applyButtonKey,
      favoriteButtonKey,
      publishedDateKey,
      deadlineKey,
      companyLocationKey;

  JobListTileWidget(
    this.jobModel, {
    this.onTap,
    this.index,
    this.onFavorite,
    this.onApply,
    this.listTileKey,
    this.applyButtonKey,
    this.favoriteButtonKey,
    this.deadlineKey,
    this.publishedDateKey,
    this.companyLocationKey,
  });

  @override
  Widget build(BuildContext context) {
    bool isFavorite = jobModel.isFavourite;
    bool isApplied = jobModel.isApplied;
    String publishDateText = jobModel.postDate == null
        ? StringResources.noneText
        : "Posted on ${DateFormatUtil().dateFormat1(jobModel.postDate)}";

    String deadLineText = jobModel.applicationDeadline == null
        ? StringResources.noneText
        : DateFormatUtil().dateFormat1(jobModel.applicationDeadline);

    bool isDateExpired = jobModel.applicationDeadline != null
        ? (jobModel.applicationDeadline.isBefore(DateTime.now()) &&
            !jobModel.applicationDeadline.isToday())
        : false;

    bool isAppliedDisabled = isApplied || isDateExpired;

    var buttonColor = Theme.of(context).primaryColor;
    var textColor = Colors.black;

    if (isApplied) {
      buttonColor = Colors.white;
      textColor = Colors.black;
    } else {
      if (isDateExpired) {
        buttonColor = Colors.grey;
        textColor = Colors.white;
      }
    }

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 10;
//    bool isTabLayout = MediaQuery.of(context).size.width > kMidDeviceScreenSize;

    var companyLogo = Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: scaffoldBackgroundColor,
      ),
      child: CachedNetworkImage(
        imageUrl:
            jobModel.profilePicture ?? kCompanyNetworkImagePlaceholder,
        placeholder: (context, _) => Image.asset(kCompanyImagePlaceholder),
      ),
    ); //That pointless fruit logo
    var jobTitle = Text(
      jobModel.title ?? "",
      style: titleStyle,
      key: Key('jobTileJobTitle' + index.toString()),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
    var companyName = Text(
      jobModel.companyName ?? "",
      key: Key('jobTileCompanyName' + index.toString()),
      style: subTitleStyle,
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
              jobModel.jobCity.swapValueByComa ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: subTitleStyle,
              key: companyLocationKey,
            ),
          )
        ],
      ),
    );
    var heartButton = ValueBuilder<bool>(
        initialValue: false,
        builder: (bool v, updateFn) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Tooltip(
          message: isFavorite
              ? StringResources.removeFromFavoriteText
              : StringResources.addToFavoriteText,
          child: v? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Loader(),
          ):InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: (){
              if( onFavorite != null){
                updateFn(true);
                onFavorite().then((value) {
                  updateFn(false);
                });
              }

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    key: favoriteButtonKey,
                    color: isFavorite ? AppTheme.colorPrimary : Colors.white,
                    size: 25,
                  ),
                  Icon(
                    Icons.favorite_border,
                    color: isFavorite ? Colors.black : Colors.grey[600],
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });

    // var applyButton = JobApplyButton(
    //   applicationDeadline: jobModel.applicationDeadline,
    //   onPressedApply: onApply,
    //   isApplied: jobModel.isApplied,
    //   key: applyButtonKey,
    // );
    var applyButton = Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: buttonColor,
      child: Container(
        alignment: Alignment.center,
        height: 30,
        width: 80,
        // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(StringResources.detailsText,
            style: TextStyle(color: textColor, fontSize: 15)),
      ),
    );
    var applicationDeadlineWidget = Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.solidClock, size: iconSize, color: subtitleColor),
        SizedBox(width: 5),
        Text(
          deadLineText,
          style: subTitleStyle,
          key: deadlineKey,
        ),
      ],
    );
    var salary = Row(
      children: <Widget>[
        Icon(FontAwesomeIcons.moneyBill, size: iconSize, color: subtitleColor),
        SizedBox(width: 5),
        Text(
          deadLineText,
          style: subTitleStyle,
          key: deadlineKey,
        ),
      ],
    );
    var publishDate = (jobModel.postDate == null)
        ? SizedBox()
        : Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidCalendar,
                size: iconSize,
                color: subtitleColor,
              ),
              SizedBox(width: 5),
              Text(
                publishDateText,
                style: subTitleStyle,
                key: publishedDateKey,
              ),
            ],
          );

    return Container(
      key: listTileKey,
      decoration: BoxDecoration(
          color: scaffoldBackgroundColor, boxShadow: CommonStyle.boxShadow
//        borderRadius: BorderRadius.circular(5),
//        boxShadow: [
//        boxShadow: [
//          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
//          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10),
//        ],
          ),
      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
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
                        if (jobModel.jobCity != null) companyLocation,
                      ],
                    )),
                    SizedBox(width: 8),
                    if (Provider.of<AuthViewModel>(context).isLoggerIn)
                      heartButton,
                  ],
                ),
              ),
              //Job Title
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    publishDate,
                    if (jobModel.applicationDeadline != null)
                      // applicationDeadlineWidget,
                      applicationDeadlineWidget,
                    applyButton,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
