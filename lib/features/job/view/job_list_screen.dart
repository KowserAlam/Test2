import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
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

class _JobListScreenState extends State<JobListScreen>
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
        Provider.of<JobListViewModel>(context, listen: false);
    jobListViewModel.getJobList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          jobListViewModel.hasMoreData &&
          !jobListViewModel.isFetchingData) {
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
      child:
          Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {
        var jobList = jobListViewModel.jobList;
        var isInSearchMode = jobListViewModel.isInSearchMode;
        debugPrint("${jobList.length}");
        return Scaffold(
          appBar: AppBar(
            title: Text(StringUtils.jobListText),
            bottom: jobListViewModel.isInSearchMode
                ? AppBar(
                    automaticallyImplyLeading: false,
                    title: TextField(
                      controller: _searchTextEditingController,
                      onChanged: jobListViewModel.addSearchQuery,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: StringUtils.searchText,
                          hintStyle: TextStyle(color: Color(0xffdddddd))),
                    ),
                  )
                : null,
            actions: [
              IconButton(
                icon: Icon(isInSearchMode ? Icons.close : Icons.search),
                onPressed: () {
                  _searchTextEditingController?.clear();
                  jobListViewModel.toggleIsInSearchMode();
                },
              )
            ],
          ),
          drawer: Drawer(
              child: AppDrawer(
            routeName: 'job_list',
          )),
          body: RefreshIndicator(
            onRefresh: () async {
              return Provider.of<JobListViewModel>(context, listen: false)
                  .refresh();
            },
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                if (jobListViewModel.isFetchingData)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Loader(),
                  ),
                (jobListViewModel.jobList.length == 0)?
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(StringUtils.noJobsFound),
                  ),
                ):
                ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: jobList.length + 1,
//              separatorBuilder: (context,index)=>Divider(),
                    itemBuilder: (context, index) {
                      if (index == jobList.length) {
                        return jobListViewModel.isFetchingMoreData
                            ? Padding(
                                padding: EdgeInsets.all(15),
                                child: Loader())
                            : SizedBox();
                      }

                      JobModel job = jobList[index];

                      return JobListTileWidget(
                        job,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => JobDetails(
                                    jobModel: job,
                                    index: index,
                                  )));
                        },
                        onFavorite: () {
                          jobListViewModel.addToFavorite(job.jobId, index);
                        },
                        onApply: job.isApplied
                            ? null
                            : () {
                                _showApplyForJobDialog(job, index);
                              },
                      );
                    }),

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
