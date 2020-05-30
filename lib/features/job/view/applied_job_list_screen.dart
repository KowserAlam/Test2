import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile.dart';
import 'package:p7app/features/job/view/widgets/no_applied_jobs_widget.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class AppliedJobListScreen extends StatefulWidget {
  AppliedJobListScreen({Key key}) : super(key: key);

  @override
  _AppliedJobListScreenState createState() => _AppliedJobListScreenState();
}

class _AppliedJobListScreenState extends State<AppliedJobListScreen>
    with AfterLayoutMixin, TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  AnimationController controller;
  TextEditingController _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    var jobListViewModel =
        Provider.of<AppliedJobListViewModel>(context, listen: false);
    jobListViewModel.getJobList();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _searchTextEditingController?.clear();
        return Provider.of<AppliedJobListViewModel>(context, listen: false)
            .refresh();
      },
      child: Consumer<AppliedJobListViewModel>(
          builder: (context, appliedJobListViewModel, _) {
        var jobList = appliedJobListViewModel.jobList;

        debugPrint("${jobList.length}");
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(StringUtils.appliedJobsText),
          ),
          body:  appliedJobListViewModel.shouldShowLoader
              ? Center(
            child: Loader(),
          ):ListView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            children: [

              appliedJobListViewModel.shouldShowNoJobs
                  ? NoAppliedJobsWidget()
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: jobList.length,
//              separatorBuilder: (context,index)=>Divider(),
                      itemBuilder: (context, index) {
                        JobListModel job = jobList[index];

                        return JobListTile(
                          job,
                          onFavorite: () {
                            appliedJobListViewModel
                                .addToFavorite(job.jobId, index)
                                .then((value) {
                              return Provider.of<JobListViewModel>(context, listen: false)
                                  .refresh();
                            });
                          },
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => JobDetails(
                                          slug: job.slug,
                                          fromJobListScreenType:
                                              JobListScreenType.applied,
                                        )));
                          },
                        );
                      }),
            ],
          ),
        );
      }),
    );
  }

  _showApplyForJobDialog(JobModel jobModel, int index) {
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
                  Provider.of<JobListViewModel>(context, listen: false)
                      .applyForJob(jobModel.jobId, index);
                  Navigator.pop(context);
                },
                child: Text(StringUtils.yesText),
              ),
            ],
          );
        });
  }
}
