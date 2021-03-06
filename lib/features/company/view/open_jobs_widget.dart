import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_list_model.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/features/job/repositories/job_repository.dart';
import 'package:p7app/features/job/view/job_details_screen.dart';
import 'package:p7app/features/job/view/widgets/job_list_tile_widget.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/common_prompt_dialog.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';

class OpenJobsWidget extends StatefulWidget {
  final String companyName;

  OpenJobsWidget(this.companyName);

  @override
  _OpenJobsWidgetState createState() => _OpenJobsWidgetState();
}

class _OpenJobsWidgetState extends State<OpenJobsWidget> {
  final TextStyle sectionTitleFont =
      TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
  List<JobListModel> _jobs = [];
  bool _isBusy = true;


  _showApplyForJobDialog(JobListModel job, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return CommonPromptDialog(
            titleText: StringResources.doYouWantToApplyText,
            onCancel: () {
              Navigator.pop(context);
            },
            onAccept: () async{
              bool isSuccessful =
              await JobRepository().applyForJob(job.jobId);
              if (isSuccessful) {
                _jobs[index].isApplied = true;
                if(this.mounted)
                  setState(() {});
              }
              Navigator.pop(context);
            },
          );
        });
  }
  @override
  void initState() {
    JobRepository().getOpenJobs(widget.companyName).then((value) {
      if (this.mounted) {
        setState(() {
          _jobs = value;
          _isBusy = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color sectionColor = Theme.of(context).backgroundColor;
    if (_isBusy) {
      return Loader();
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: sectionColor,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.solidClone,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                StringResources.openJobsText,
                style: sectionTitleFont,
              )
            ],
          ),
        ),


        SizedBox(
          key: Key ('openJobsSizedBox'),
            height: 2
        ),
        (_jobs.length == 0)
            ? Container(
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: sectionColor,
          ),
          child: Center(
            child: Text(StringResources.noOpenJobsFound, key: Key('noOpenJobsFoundKey')),
          ),
        )
            :        Padding(
              padding: const EdgeInsets.only(top:2),
              child: Column(
          children: List.generate(_jobs.length, (index) {
              var job = _jobs[index];
              return JobListTileWidget(
                job,
                index: index,
                companyLocationKey: Key('openJobsCompanyLocation${index}'),
                deadlineKey: Key('openJobsDeadline${index}'),
                publishedDateKey: Key('openJobsPublishedDate${index}'),
                favoriteButtonKey: Key('openJobsFavorite${index}'),
                applyButtonKey: Key('openJobsApplyButton${index}'),
                listTileKey: Key ('companyDetailsOpenJobsKey${index}'),
                onApply: () async {
                  _showApplyForJobDialog(job,index);
                },
                onFavorite: () async {
                  bool isSuccessful =
                      await JobRepository().addToFavorite(job.jobId);
                  if (isSuccessful) {
                    _jobs[index].isFavourite = !_jobs[index].isFavourite;
                    if(this.mounted)
                    setState(() {});
                    return true;
                  }else{
                    return false;
                  }

                },
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => JobDetailsScreen(
                            slug: job.slug,
                          )));
                },
              );
          }),
        ),
            ),
      ],
    );
  }
}
