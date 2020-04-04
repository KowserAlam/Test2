import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/auth/provider/login_view_model.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:p7app/features/home_screen/view_model/home_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/widgets/job_list_item_widget.dart';
import 'package:p7app/main.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/util/strings_utils.dart';
import 'package:p7app/main_app/view/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({Key key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> with AfterLayoutMixin{
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<HomeViewModel>(context,listen: false).getJobList();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(child: AppDrawer(routeName: 'home',)),
        body: Consumer<HomeViewModel>(builder: (BuildContext context, homeViewModel, Widget child) {
          var jobList = homeViewModel.jobList;
          print(jobList.length);
          return ListView.builder(
            itemCount: jobList.length,
//              separatorBuilder: (context,index)=>Divider(),
              itemBuilder: (context,index){
            JobModel job = jobList[index];
            return JobListItemWidget(job);
          });
        },),
      ),
    );
  }


}
