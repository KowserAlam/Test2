import 'package:flutter/material.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:provider/provider.dart';

class JobListSearchScreen extends StatefulWidget {
  JobListSearchScreen({Key key}) : super(key: key);

  @override
  _JobListSearchScreenState createState() => _JobListSearchScreenState();
}

class _JobListSearchScreenState extends State<JobListSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {
      return Scaffold(
        appBar: AppBar(
          title: TextField(onChanged: jobListViewModel.searchQuerySink,style: TextStyle(color: Colors.white),),
        ),
        body: ListView.builder(
            itemCount: jobListViewModel.jobList.length,
            itemBuilder: (context, int index) {
              var jobModel = jobListViewModel.jobList[index];
              return JobListTileWidget(jobModel);
            }),
      );
    }
    );
  }
}
