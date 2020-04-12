import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/widgets/job_list_item_widget.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class JobListScreen extends StatefulWidget {
  JobListScreen({Key key}) : super(key: key);

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> with AfterLayoutMixin{

  ScrollController _scrollController = ScrollController();

  @override
  void afterFirstLayout(BuildContext context) {
    var jobListViewModel = Provider.of<JobListViewModel>(context,listen: false);
    jobListViewModel.getJobList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          jobListViewModel.hasMoreData && !jobListViewModel.isFetchingData) {
        jobListViewModel.getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringUtils.jobListText),
        ),
        drawer: Drawer(child: AppDrawer(routeName: 'job_list',)),
        body: Consumer<JobListViewModel>(builder: (BuildContext context, homeViewModel, Widget child) {
          var jobList = homeViewModel.jobList;
          print(jobList.length);
          return ListView.builder(
            controller: _scrollController,
            itemCount: jobList.length+1,
//              separatorBuilder: (context,index)=>Divider(),
              itemBuilder: (context,index){
                if(index == jobList.length){
                  return homeViewModel.isFetchingData?Padding(padding: EdgeInsets.all(15),child: Loader()):SizedBox();
                }

            JobModel job = jobList[index];


            return JobListItemWidget(job);
          });
        },),
      ),
    );
  }


}
