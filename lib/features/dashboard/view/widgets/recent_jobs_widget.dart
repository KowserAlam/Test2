import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/all_job_list_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';

class RecentJobs extends StatefulWidget {
  @override
  _RecentJobsState createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {
  double cardWidth = 180;
  double cardHeight = 240;


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var subtitleColor = isDarkMode ? Colors.white : AppTheme.grey;
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    var titleStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    var subTitleStyle = TextStyle(fontSize: 12, color: subtitleColor);
    double iconSize = 12;

    Widget listItem(JobListModel jobListModel) {
      String publishDateText = jobListModel.postDate == null
          ? StringResources.noneText
          : DateFormatUtil().dateFormat1(jobListModel.postDate);

      String deadLineText = jobListModel.applicationDeadline == null
          ? StringResources.noneText
          : DateFormatUtil().dateFormat1(jobListModel.applicationDeadline);

      return LayoutBuilder(builder: (context, c) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => JobDetailsScreen(
                  slug: jobListModel.slug,
                  fromJobListScreenType: JobListScreenType.main,
                )));
          },
          child: Container(
            height: cardHeight-20,
            width: cardWidth,
            margin: EdgeInsets.only(right: 15),
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  child: Container(
                    height: cardHeight-40,
                    width: cardWidth,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey[200]),
                        color: Colors.grey.shade100,
                        gradient: LinearGradient(
                            colors: [Colors.grey[200], Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              offset: Offset(4,4),
                              blurRadius: 2
                          ),
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(-1,-1),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 45,),
                        Text(jobListModel.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        SizedBox(height: 5,),
                        Text(jobListModel.companyName, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.blueAccent),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(height: 15, thickness: 1,),
                        ),
                        SizedBox(height: 5,),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                    jobListModel.jobCity.swapValueByComa ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: subTitleStyle,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
                                SizedBox(width: 5),
                                Text(
                                  deadLineText,
                                  style: subTitleStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Icon(
                                  FeatherIcons.calendar,
                                  size: iconSize,
                                  color: subtitleColor,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  publishDateText,
                                  style: subTitleStyle,
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: cardWidth/3,
                  top: 0,
                  child: Container(
                    height: cardWidth/3,
                    width: cardWidth/3,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.grey[200]),
                        boxShadow: [BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6)]
                    ),
                    child: CachedNetworkImage(
                      imageUrl: jobListModel.profilePicture ?? "",
                      placeholder: (context, _) => Image.asset(kCompanyImagePlaceholder),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }


    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.recebtJobsList;
    if (vm.recebtJobsList.length == 0)
      return SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Text(StringResources.recentJobsText, style: Theme
              .of(context)
              .textTheme
              .subtitle1,),
          SizedBox(height: 10,),
          Container(
            height: cardHeight,
            child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var recentJob = list[index];
                return listItem(recentJob);
              },
            ),
          ),
        ],
      ),
    );
  }


}
