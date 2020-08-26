import 'package:flutter/material.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';


class AllJobListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var jobListViewModel = Provider.of<JobListViewModel>(context);
    var jobList = jobListViewModel.jobList;
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 4),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: jobList.length + 1,
        itemBuilder: (context, index) {
          if (index == jobList.length) {
            return jobListViewModel.isFetchingMoreData
                ? Padding(padding: EdgeInsets.all(15), child: Loader())
                : SizedBox();
          }

          JobListModel job = jobList[index];

          return JobListTileWidget(
            job,
            index: index,
            applyButtonKey: Key('allJobsApplyKey'+index.toString()),
            listTileKey: Key('allJobsTileKey'+index.toString()),
            favoriteButtonKey: Key('allJobsListFavoriteButtonKey'+index.toString()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => JobDetailsScreen(
                        slug: job.slug,
                        fromJobListScreenType: JobListScreenType.main,
                      )));
            },
            onFavorite: () {
              jobListViewModel.addToFavorite(job.jobId, index);
            },
            onApply: job.isApplied
                ? null
                : () {
                    _showApplyForJobDialog(context, job, index);
                  },
          );
        });
  }

  _showApplyForJobDialog(context, JobListModel jobModel, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.doYouWantToApplyText,
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () {
              Provider.of<JobListViewModel>(context, listen: false)
                  .applyForJob(jobModel.jobId, index);
              Navigator.pop(context);
            },
          );
        });
  }
}
