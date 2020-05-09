import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view/widgets/applied_job_list_tile.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
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

//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent &&
//          jobListViewModel.hasMoreData &&
//          !jobListViewModel.isFetchingData) {
//        jobListViewModel.getMoreData();
//      }
//    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child:
      Consumer<AppliedJobListViewModel>(builder: (context, appliedJobListViewModel, _) {
        var jobList = appliedJobListViewModel.jobList;
        var isInSearchMode = appliedJobListViewModel.isInSearchMode;
        debugPrint("${jobList.length}");
        return Scaffold(
          appBar: AppBar(
            title: Text(StringUtils.appliedJobsText),
//            actions: [
//              IconButton(
//                icon: Icon(isInSearchMode ? Icons.close : Icons.search),
//                onPressed: () {
//                  _searchTextEditingController?.clear();
//                  jobListViewModel.toggleIsInSearchMode();
//                },
//              )
//            ],
          ),
          drawer: Drawer(
              child: AppDrawer(
                routeName: 'applied_job_list',
              )),
          body: RefreshIndicator(
            onRefresh: () async {
              return Provider.of<JobListViewModel>(context, listen: false)
                  .refresh();
            },
            child: Column(
              children: [
                if (appliedJobListViewModel.isInSearchMode)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,8,8),
                    child: CustomTextFormField(
                      controller: _searchTextEditingController,
                      onChanged: appliedJobListViewModel.addSearchQuery,
                      hintText: StringUtils.searchText,
                    ),
                  ),
                Expanded(
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    children: [


                      if (appliedJobListViewModel.isFetchingData)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Loader(),
                        ),
                      (appliedJobListViewModel.jobList.length == 0 && appliedJobListViewModel.isFetchingData)
                          ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(StringUtils.noAppliedJobsFound),
                        ),
                      )
                          : ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          itemCount: jobList.length + 1,
//              separatorBuilder: (context,index)=>Divider(),
                          itemBuilder: (context, index) {
                            if (index == jobList.length) {
                              return appliedJobListViewModel.isFetchingMoreData
                                  ? Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Loader())
                                  : SizedBox();
                            }

                            JobListModel job = jobList[index];

                            return AppliedJobListTileWidget(job,

                                  () {
                              appliedJobListViewModel.addToFavorite(job.jobId, index);
                            },
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
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
