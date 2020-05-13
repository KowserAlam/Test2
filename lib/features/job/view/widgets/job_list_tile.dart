import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/api_helpers/api_client.dart';
import 'package:p7app/main_app/api_helpers/urls.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:provider/provider.dart';

class FavoriteJobListTileWidget extends StatefulWidget {
  final JobListModel jobListModel;
  //final Function onTap;
  //final Function onFavorite;

  FavoriteJobListTileWidget(this.jobListModel);

  @override
  _FavoriteJobListTileWidgetState createState() => _FavoriteJobListTileWidgetState();
}

class _FavoriteJobListTileWidgetState extends State<FavoriteJobListTileWidget> {

  Future<bool> addToFavorite(String jobId,) async {
    BotToast.showLoading();
    var userId =
    await AuthService.getInstance().then((value) => value.getUser().userId);
    var body = {'user_id': userId, 'job_id': jobId};

    try {
      ApiClient client =  ApiClient();
      var res = await client.postRequest(Urls.favouriteJobAddUrl, body);
      print(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        Provider.of<JobListViewModel>(context, listen: false)
            .refresh();
        setState(() {});
        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);
      Provider.of<JobListViewModel>(context, listen: false)
          .refresh();
      return false;
    }
  }

  Future<bool> applyForJob(String jobId,) async {
    BotToast.showLoading();
    var userId =
    await AuthService.getInstance().then((value) => value.getUser().userId);
    var body = {'user_id': userId, 'job_id': jobId};

    try {
      ApiClient client =  ApiClient();
      var res = await client.postRequest(Urls.applyJobOnlineUrl, body);
      print(res.body);

      if (res.statusCode == 200) {
        BotToast.closeAllLoading();
        BotToast.showText(
            text: StringUtils.successfullyAppliedText,
            duration: Duration(seconds: 2));

        return true;
      } else {
        BotToast.closeAllLoading();
        BotToast.showText(text: StringUtils.unableToSaveData);
        return false;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      BotToast.showText(text: StringUtils.unableToSaveData);
      print(e);

      return false;
    }
  }

  _showApplyDialog(){
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
                  applyForJob(widget.jobListModel.jobId)
                      .then((value) {
                    setState(() {
                      widget.jobListModel.isApplied = value;
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


  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.jobListModel.isFavourite;
    bool isApplied = widget.jobListModel.isApplied;

    String publishDateText = widget.jobListModel.createdAt == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobListModel.createdAt);

    String deadLineText = widget.jobListModel.applicationDeadline == null
        ? StringUtils.unspecifiedText
        : DateFormatUtil().dateFormat1(widget.jobListModel.applicationDeadline);
    bool isDateExpired = widget.jobListModel.applicationDeadline != null
        ? DateTime.now().isAfter(widget.jobListModel.applicationDeadline)
        : true;

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
        placeholder: (context, _) => Image.asset(
          kCompanyImagePlaceholder,
          fit: BoxFit.cover,
        ),
        imageUrl: widget.jobListModel?.profilePicture ?? "",
      ),
    ); //That pointless fruit logo
    var jobTitle = Text(
      widget.jobListModel.title ?? "",
      style: titleStyle,
    );
    var companyName = Text(
      widget.jobListModel.companyName ?? "",
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
              widget.jobListModel.jobLocation ?? "",
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
        onTap: () {

          addToFavorite(widget.jobListModel.jobId)
              .then((value) {
            widget.jobListModel.isFavourite = !widget.jobListModel.isFavourite;
            setState(() {
            });
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

    var applyButton = Material(
      color: widget.jobListModel.isApplied ? Colors.blue[200]
          : (isDateExpired?Colors.grey:Theme.of(context).accentColor),
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: isApplied || isDateExpired
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
          widget.jobListModel.employmentStatus != null
              ? widget.jobListModel.employmentStatus
              : StringUtils.unspecifiedText,
          style: TextStyle(color: subtitleColor),
        ),
      ],
    );
    var publishDateWidget = Row(
      children: <Widget>[
        Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
        SizedBox(width: 5),
        Text(
          publishDateText,
          style: TextStyle(color: subtitleColor, fontWeight: FontWeight.w100),
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
          deadLineText,
          style: TextStyle(color: subtitleColor, fontWeight: FontWeight.w100),
        ),
      ],
    );
    return GestureDetector(
      //onTap: widget.onTap,
      onTap: (){
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => JobDetails(slug: widget.jobListModel.slug,)));
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
                          widget.jobListModel.jobLocation== null?SizedBox():companyLocation,
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
