import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/recentactivity/recentactivity_view_model.dart';
import 'package:p7app/features/recentactivity/recentactivitymodel.dart';
import 'package:p7app/features/user_profile/views/screens/profile_screen.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/page_state_builder.dart';

class RecentActivityScreen extends StatefulWidget {
  @override
  _RecentActivityScreenState createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  final _ = Get.put(RecentActivityViewModel());

  final vm = Get.find<RecentActivityViewModel>();

  @override
  void initState() {
    vm.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.recentActivityText),
      ),
      body: Obx(() {
        var activityList = vm.activityList;
        return PageStateBuilder(
            onRefresh: vm.getData,
            showLoader: vm.shouldShowLoader,
            showError: vm.shouldShowError,
            appError: vm.appError.value,
            child: ListView.separated(
              itemCount: activityList.length,
              separatorBuilder: (c,i)=>Divider(height: 1,),
              itemBuilder: (context, index) {
                var activity = activityList[index];
                return ListTile(
                  onTap: () {
                    switch (activity.type) {
                      case ActivityType.update_pro:
                        Get.to(ProfileScreen());
                        break;
                      case ActivityType.apply_pro:
                        Get.to(JobDetailsScreen(
                            slug: activity.reletedJob?.slug ?? ""));
                        break;
                      case ActivityType.favorite_pro:
                        Get.to(JobDetailsScreen(
                            slug: activity.reletedJob?.slug ?? ""));
                        break;
                    }
                  },
                  leading: SizedBox(
                      width: 30,
                      child: Center(child: Icon(_getIcon(activity),size: 15,color: Colors.green,))),

                  title: _getTitle(activity),
                  subtitle: Text("${activity.time}",style: TextStyle(fontStyle: FontStyle.italic),),
                );
              },
            ));
      }),
    );
  }

  Widget _getTitle(RecentActivityModel activity) {
    String prefix = "";
    String suffix = "";

    switch (activity.type) {
      case ActivityType.update_pro:
        {
          prefix = "You updated your ";
          suffix = "${activity.updatedSection}" ?? "";
          break;
        }
      case ActivityType.apply_pro:
        {
          prefix = "You Applied a Job ";
          suffix = activity?.reletedJob?.title ?? "";
          break;
        }

      case ActivityType.favorite_pro:
        {
          prefix = "You Favorite a Job ";
          suffix = activity?.reletedJob?.title ?? "";
          break;
        }
    }
    return Text.rich(TextSpan(children: [
      TextSpan(text: prefix),
      TextSpan(text: suffix, style: TextStyle(fontWeight: FontWeight.bold)),
    ]));
  }

  IconData _getIcon(RecentActivityModel activity) {
     switch (activity.type) {
      case ActivityType.update_pro:
        {
          return FontAwesomeIcons.bolt;
        }
      case ActivityType.apply_pro:
        {
          return FontAwesomeIcons.solidCheckSquare;
        }

      case ActivityType.favorite_pro:
        {
          return FontAwesomeIcons.solidHeart;
        }
    }
    return FontAwesomeIcons.bolt;
  }
}
