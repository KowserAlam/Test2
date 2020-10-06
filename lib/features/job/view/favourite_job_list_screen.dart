import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/job/view/widgets/jobs_screen_segment_control_bar.dart';
import 'package:p7app/features/job/view/widgets/no_favourite_jobs_widget.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';

class FavouriteJobListScreen extends StatefulWidget {
  FavouriteJobListScreen({Key key}) : super(key: key);

  @override
  _FavouriteJobListScreenState createState() => _FavouriteJobListScreenState();
}

class _FavouriteJobListScreenState extends State<FavouriteJobListScreen> {
  ScrollController _scrollController = ScrollController();
  AnimationController controller;
  TextEditingController _searchTextEditingController = TextEditingController();
  var __vm = Get.put(FavouriteJobListViewModel());
  FavouriteJobListViewModel vm = Get.find();

  @override
  void initState() {
    vm.getJobList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        vm.getMoreData();
      }
    });
    super.initState();
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
        return vm.refresh();
      },
      child: Obx(() {
        var jobList = vm.jobList;
        debugPrint("${jobList.length}");
        return Scaffold(
          appBar: AppBar(
            title: Text(
              StringResources.favoriteJobsText,
              key: Key('faqAppBarTitleKey'),
            ),
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
                    child: vm.shouldShowLoader
                        ? Center(
                            child: Loader(),
                          )
                        : ListView(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: _scrollController,
                            children: [
                              vm.shouldShowNoJobs
                                  ? NoFavouriteJobsWidget()
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: jobList.length+1,
                                      itemBuilder: (context, index) {
                                        if (index == jobList.length) {
                                          return Obx(() =>
                                              vm.isFetchingMoreData.value
                                                  ? Loader()
                                                  : SizedBox());
                                        }

                                        JobListModel job = jobList[index];

                                        return JobListTileWidget(
                                          job,
                                          index: index,
                                          applyButtonKey: Key(
                                              'favoriteApplyKey' +
                                                  index.toString()),
                                          listTileKey: Key('favoriteTileKey' +
                                              index.toString()),
                                          deadlineKey:
                                              Key('favoriteDeadline$index'),
                                          publishedDateKey: Key(
                                              'favoritePublishedDate$index'),
                                          companyLocationKey: Key(
                                              'favoriteCompanyLocation$index'),
                                          favoriteButtonKey: Key(
                                              'favoriteJobsListFavoriteButtonKey' +
                                                  index.toString()),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
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
                                            return vm
                                                .addToFavorite(job.jobId, index)
                                                .then((value) {
                                              return vm.refresh();
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
              vm.applyForJob(job.jobId, index).then((value) {
                Navigator.pop(context);
                return vm.refresh();
              });
            },
          );
        });
  }
}
