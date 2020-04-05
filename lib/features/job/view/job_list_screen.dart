import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/widgets/job_list_item_widget.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({Key key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> with AfterLayoutMixin{
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<JobListViewModel>(context,listen: false).getJobList();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(child: AppDrawer(routeName: 'home',)),
        body: Consumer<JobListViewModel>(builder: (BuildContext context, homeViewModel, Widget child) {
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
