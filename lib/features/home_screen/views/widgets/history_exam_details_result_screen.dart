import 'package:after_layout/after_layout.dart';
import 'package:p7app/features/assessment/models/candidate_exam_model.dart';
import 'package:p7app/features/home_screen/providers/result_provider.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HistoryExamDetails extends StatefulWidget {
  final CandidateExamModel candidateExamModel;

  HistoryExamDetails(this.candidateExamModel);

  @override
  _HistoryExamDetailsState createState() => _HistoryExamDetailsState();
}

class _HistoryExamDetailsState extends State<HistoryExamDetails>
    with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ResultProvider>(context)
        .fetResultData(widget.candidateExamModel.regId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.candidateExamModel.examName),
      ),
      body: Consumer<ResultProvider>(builder: (context, resultProvider, c) {
        if (resultProvider.isBusy) {
          return Center(
            child: Loader(),
          );
        } else {
          return resultProvider.result != null
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text("Exam Name: ${widget.candidateExamModel.examName}", style: Theme.of(context).textTheme.title),
                        SizedBox(height: 10),
                        Text("Exam Id: ${widget.candidateExamModel.examId}", style: Theme.of(context).textTheme.title),
                        SizedBox(height: 10),
                        Text(
                          "You got ${resultProvider.result.correctAns} correct  out of ${resultProvider.result.numberOfQuestion}",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.title.color,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularPercentIndicator(
                          radius: 200.0,
                          lineWidth: 20.0,
                          animation: true,
                          percent:
                              resultProvider.result.percentageOfRightAns / 100,
                          startAngle: 180,
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.red[400],
                          center: Text(
                            "${resultProvider.result.percentageOfRightAns.round()}%",
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          progressColor: Colors.green[600],
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox();
        }
      }),
    );
  }
}
