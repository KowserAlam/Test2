import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/sort_item.dart';
import 'package:p7app/features/job/repositories/job_list_sort_items_repository.dart';
import 'package:p7app/features/job/view/job_details.dart';
import 'package:p7app/features/job/view/widgets/job_list_filters_widget.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/user_profile/models/skill.dart';
import 'package:p7app/features/user_profile/repositories/skill_list_repository.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/widgets/custom_text_field.dart';
import 'package:p7app/main_app/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:p7app/main_app/widgets/toggle_app_theme_widget.dart';
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
  var _scaffoldKey = GlobalKey<ScaffoldState>();

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
          _scrollController.position.maxScrollExtent) {
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
    var backgroundColor = Theme.of(context).backgroundColor;
    var scaffoldBackgroundColor = Theme.of(context).backgroundColor;

    return FlavorBanner(
      child:
          Consumer<JobListViewModel>(builder: (context, jobListViewModel, _) {
        var jobList = jobListViewModel.jobList;
        var isInSearchMode = jobListViewModel.isInSearchMode;
        debugPrint("${jobList.length}");
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(StringUtils.jobListText),
            actions: [
              IconButton(
                icon: Icon(isInSearchMode ? Icons.close : Icons.search),
                onPressed: () {
                  _searchTextEditingController?.clear();
                  jobListViewModel.toggleIsInSearchMode();
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              )
            ],
          ),
          drawer: Drawer(
              child: AppDrawer(
            routeName: 'job_list',
          )),
          endDrawer: Drawer(
            child: JobListFilterWidget(),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              _searchTextEditingController?.clear();
              return Provider.of<JobListViewModel>(context, listen: false)
                  .refresh();
            },
            child: Column(
              children: [
                if (jobListViewModel.isInSearchMode)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: CustomTextField(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (_searchTextEditingController
                                  .text.isNotEmpty) {
                                jobListViewModel
                                    .search(_searchTextEditingController.text);
                              }
                            },
                          ),
                          controller: _searchTextEditingController,
                          hintText: StringUtils.searchText,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        decoration:
                            BoxDecoration(color: backgroundColor, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10),
                        ]),
                        child: Column(
                          children: [
//                            Container(
//                                height: 40,
//                                child: ListView(
//                                  scrollDirection: Axis.horizontal,
//                                  children: [
//
//
//                                  ],
//                                )),

//                            if (_searchTextEditingController.text.isNotEmpty && !jobListViewModel.isFetchingData)
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text(
//                                    '${jobListViewModel.totalJobCount} ${StringUtils.jobsFoundText}'),
//                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(color: backgroundColor, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), blurRadius: 10),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2), blurRadius: 10),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<SortItem>(
                              value: jobListViewModel.jobListFilters.sort ??
                                  SortItem(key: '', value: 'None'),
                              onChanged: jobListViewModel.jobListSortBy,
                              items: JobListSortItemRepository()
                                  .getList()
                                  .map((e) => DropdownMenuItem<SortItem>(
                                        key: Key(e.key),
                                        value: e,
                                        child: Text(e.value),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    children: [
                      if (jobListViewModel.isFetchingData)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Loader(),
                        ),
                      (jobListViewModel.jobList.length == 0 &&
                              !jobListViewModel.isFetchingData)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(StringUtils.noJobsFound),
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => JobDetails(
                                                  jobModel: job,
                                                  index: index,
                                                )));
                                  },
                                  onFavorite: () {
                                    jobListViewModel.addToFavorite(
                                        job.jobId, index);
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
