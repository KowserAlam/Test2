import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/all_job_list_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/app_theme/common_style.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/date_format_uitl.dart';
import 'package:provider/provider.dart';
import 'package:p7app/method_extension.dart';
import 'package:shimmer/shimmer.dart';

class RecentJobs extends StatefulWidget {
  @override
  _RecentJobsState createState() => _RecentJobsState();
}

class _RecentJobsState extends State<RecentJobs> {
  double cardWidth = 220;
  double cardHeight = 180;


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
          ? null
          : DateFormatUtil().dateFormat1(jobListModel.postDate);

      String deadLineText = jobListModel.applicationDeadline == null
          ? null
          : DateFormatUtil().dateFormat1(jobListModel.applicationDeadline);

      return LayoutBuilder(builder: (context, c) {
        return Card(
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => JobDetailsScreen(
                    slug: jobListModel.slug,
                    fromJobListScreenType: JobListScreenType.main,
                  )));
            },
            child: Container(
              height: cardHeight,
              width: cardWidth,
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        child: CachedNetworkImage(
                          imageUrl: jobListModel.profilePicture ?? "",
                          placeholder: (context, _) => Image.asset(kCompanyImagePlaceholder),),
                      ),
                      SizedBox(width: 3,),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(jobListModel.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, height: 1.3, fontWeight: FontWeight.bold),),
                            SizedBox(height: 7,),
                            Text(jobListModel.companyName, style: TextStyle(fontSize: 10, color: Colors.blueAccent),),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Divider(height: 20,),
                  ),
                  jobListModel.jobCity!=null?Row(
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
                          jobListModel.jobCity.swapValueByComa,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: subTitleStyle,
                        ),
                      )
                    ],
                  ):SizedBox(),
                  SizedBox(height: 7,),
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
                  ),
                  SizedBox(height: 7,),
                  deadLineText!=null?Row(
                    children: <Widget>[
                      Icon(FeatherIcons.clock, size: iconSize, color: subtitleColor),
                      SizedBox(width: 5),
                      Text(
                        deadLineText,
                        style: subTitleStyle,
                      ),
                    ],
                  ):SizedBox()
                ],
              ),
            ),
          ),
        );
      });
    }


    var vm = Provider.of<DashboardViewModel>(context);
    var list = vm.recebtJobsList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          Row(children: [
            SizedBox(width: 8,),
            Text(StringResources.recentJobsText,
              style: CommonStyle.dashboardSectionTitleTexStyle,
            ),
          ],),
          // Text(StringResources.recentJobsText, style: Theme
          //     .of(context)
          //     .textTheme
          //     .subtitle1,),
          SizedBox(height: 10,),
          vm.recebtJobsList.length == 0?
          Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Container(
              height: cardHeight,
              child: ListView.builder(
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var recentJob = JobListModel();
                  return listItem(recentJob);
                },
              ),
            ),
          ):
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
