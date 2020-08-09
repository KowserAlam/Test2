import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:p7app/features/auth/view/widgets/custom_text_field_rounded.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/jobs_screen_segment_control_bar.dart';

import 'package:p7app/features/job/view/widgets/no_favourite_jobs_widget.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/flavour/flavor_banner.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/custom_text_from_field.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class FavouriteJobListScreen extends StatefulWidget {
  FavouriteJobListScreen({Key key}) : super(key: key);

  @override
  _FavouriteJobListScreenState createState() => _FavouriteJobListScreenState();
}

class _FavouriteJobListScreenState extends State<FavouriteJobListScreen>
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
        Provider.of<FavouriteJobListViewModel>(context, listen: false);
    jobListViewModel.getJobList(isFormOnPageLoad: true);
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
        return Provider.of<FavouriteJobListViewModel>(context, listen: false)
            .refresh();
      },
      child: Consumer<FavouriteJobListViewModel>(
          builder: (context, favoriteJobListViewModel, _) {
        var jobList = favoriteJobListViewModel.jobList;
        debugPrint("${jobList.length}");
        return Scaffold(
          appBar: AppBar(
            title: Text(StringResources.favoriteJobsText),
          ),
//          drawer: AppDrawer(
//            routeName: 'favorite_job_list',
//          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    child: favoriteJobListViewModel.shouldShowLoader
                        ? Center(
                            child: Loader(),
                          )
                        : ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: _scrollController,
                            children: [
                              favoriteJobListViewModel.shouldShowNoJobs
                                  ? NoFavouriteJobsWidget()
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: jobList.length,
                                      itemBuilder: (context, index) {
                                        JobListModel job = jobList[index];

                                        return JobListTileWidget(
                                          job,
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobDetailsScreen(
                                                          slug: job.slug,
                                                          fromJobListScreenType:
                                                              JobListScreenType
                                                                  .favorite,
                                                        )));
                                          },
                                          onApply: () {
                                            _showApplyForJobDialog(job, index);
                                          },
                                          onFavorite: () {
                                            favoriteJobListViewModel
                                                .addToFavorite(job.jobId, index)
                                                .then((value) {
                                              return Provider.of<
                                                          JobListViewModel>(
                                                      context,
                                                      listen: false)
                                                  .refresh();
                                            });
                                          },
                                        );
                                      }),
                            ],
                          ),
                  ),
                ],
              ),
              JobsScreenSegmentControlBar(),
            ],
          ),
        );
      }),
    );
  }

  _showApplyForJobDialog(JobListModel job, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.doYouWantToApplyText,
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () {
              Provider.of<FavouriteJobListViewModel>(context, listen: false)
                  .applyForJob(job.jobId, index)
                  .then((value) {
                Navigator.pop(context);
                return Provider.of<JobListViewModel>(context, listen: false)
                    .refresh();
              });
            },
          );
        });
  }
}
