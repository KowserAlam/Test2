import 'package:assessment_ishraak/features/home_screen/models/dashboard_models.dart';
import 'package:assessment_ishraak/features/recent_exam/models/recent_exam_model.dart';
import 'package:assessment_ishraak/main_app/util/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentExamListTileWidget extends StatelessWidget {
  final int index;
  final RecentExamModel recentExamModel;
//  final examDateFormat = DateFormat("dd/MM/yyyy 'at' hh:mm aa");

  RecentExamListTileWidget({
    @required this.index,
    @required this.recentExamModel,
  });

  @override
  Widget build(BuildContext context) {
    var resultStatusColor = Colors.red;
    if (recentExamModel.resultStatus == "Passed") {
      resultStatusColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: Theme.of(context).backgroundColor,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          onTap: () {},
          leading: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: FadeInImage(
              height: 50,
              width: 60,
              fit: BoxFit.cover,
              placeholder: AssetImage(kExamCoverImageAsset),
              image: NetworkImage(recentExamModel.image),
            ),
          ),
          title: Text(
            recentExamModel.examName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
              "Date: ${kDateWithTimeFormatBD.format(recentExamModel.examSubmittedDate)}"),
          trailing: Column(
            children: <Widget>[
              Text(
                recentExamModel.resultStatus,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: resultStatusColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${recentExamModel.percentageOfCorrect}%"),
            ],
          ),
        ),
      ),
    );
  }
}
