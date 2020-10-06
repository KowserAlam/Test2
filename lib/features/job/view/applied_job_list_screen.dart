import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/job/view/widgets/jobs_screen_segment_control_bar.dart';
import 'package:p7app/features/job/view/widgets/no_applied_jobs_widget.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';

class AppliedJobListScreen extends StatefulWidget {
  AppliedJobListScreen({Key key}) : super(key: key);

  @override
  _AppliedJobListScreenState createState() => _AppliedJobListScreenState();
}

class _AppliedJobListScreenState extends State<AppliedJobListScreen> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchTextEditingController = TextEditingController();
  var __vm = Get.put(AppliedJobListViewModel());
  AppliedJobListViewModel vm = Get.find();

  @override
  void initState() {
    vm.getJobList();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        vm.getMoreData();
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
    return RefreshIndicator(
      onRefresh: () async {
        _searchTextEditingController?.clear();
        return vm.refresh();
      },
      child: Obx(() {
        var jobList = vm.jobListApplied;
        debugPrint("${jobList.length}");
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(StringResources.appliedJobsText),
          ),
//          drawer: AppDrawer(
//            routeName: 'applied_job_list',
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
                                  ? NoAppliedJobsWidget()
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: jobList.length + 1,
//              separatorBuilder: (context,index)=>Divider(),
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
                                              'appliedApplyKey' +
                                                  index.toString()),
                                          listTileKey: Key('appliedTileKey' +
                                              index.toString()),
                                          favoriteButtonKey: Key(
                                              'appliedJobsListFavoriteButtonKey' +
                                                  index.toString()),
                                          onFavorite: () {
                                            return vm
                                                .addToFavorite(job.jobId, index)
                                                .then((value) {
                                              return vm.refresh();
                                            });
                                          },
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        JobDetailsScreen(
                                                          slug: job.slug,
                                                          fromJobListScreenType:
                                                              JobListScreenType
                                                                  .applied,
                                                        )));
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
}
