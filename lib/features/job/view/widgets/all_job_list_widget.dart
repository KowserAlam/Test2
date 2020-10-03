import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/job/view_model/all_job_list_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class AllJobListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var jobListViewModel = Provider.of<AllJobListViewModel>(context);
    var jobList = jobListViewModel.jobList;
    var isLoggedIn =
        Provider.of<AuthViewModel>(context, listen: false).isLoggerIn;
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 4),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: jobList.length + 1,
        itemBuilder: (context, index) {
          if (index == jobList.length) {
            if (!isLoggedIn) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        StringResources.pleaseSignInToSeeMoreJobsText,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Text(StringResources.signInButtonText),
                          onPressed: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) => SignInScreen()));

                          }),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }

            return jobListViewModel.isFetchingMoreData
                ? Padding(padding: EdgeInsets.all(15), child: Loader())
                : SizedBox();
          }

          JobListModel job = jobList[index];
          return ValueBuilder<bool>(
            builder: (v,updateFn){
            return  JobListTileWidget(
              job,
              index: index,
              applyButtonKey: Key('allJobsApplyKey' + index.toString()),
              listTileKey: Key('allJobsTileKey' + index.toString()),
              favoriteButtonKey:
              Key('allJobsListFavoriteButtonKey' + index.toString()),
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => JobDetailsScreen(
                      slug: job.slug,
                      fromJobListScreenType: JobListScreenType.main,
                      onFavourite: () {
                        job.isFavourite = !job.isFavourite;
                        jobListViewModel.jobList[index] = job;
                        updateFn(job.isFavourite);
                      },
                      onApply: () {
                        job.isApplied = true;
                        jobListViewModel.jobList[index] = job;
                        updateFn(job.isApplied);
                      },
                    )));
              },
              onFavorite: () {
                return jobListViewModel.addToFavorite(job.jobId, index);
              },
              // onApply: job.isApplied
              //     ? null
              //     : () {
              //         _showApplyForJobDialog(context, job, index);
              //       },
            );
          },);


        });
  }

  // _showApplyForJobDialog(context, JobListModel jobModel, int index) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return CommonPromptDialog(
  //           titleText: StringResources.doYouWantToApplyText,
  //           onCancel: () {
  //             Navigator.pop(context);
  //           },
  //           onAccept: () {
  //             Provider.of<AllJobListViewModel>(context, listen: false)
  //                 .applyForJob(jobModel.jobId, index);
  //             Navigator.pop(context);
  //           },
  //         );
  //       });
  // }
}
