
import 'package:assessment_ishraak/features/assessment/views/proceed_screen.dart';
import 'package:assessment_ishraak/main_app/util/cosnt_style.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:assessment_ishraak/main_app/widgets/loader.dart';
import 'package:assessment_ishraak/features/exam_center/candidate_list_provider_exam_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;


class CandidateListScreen extends StatefulWidget {
  @override
  _CandidateListScreenState createState() => _CandidateListScreenState();
}


class _CandidateListScreenState extends State<CandidateListScreen> with AfterLayoutMixin<CandidateListScreen> {
  @override
  void afterFirstLayout(BuildContext context) {
    var candidateProvider = Provider.of<CandidateProvider>(context);
    candidateProvider.fetchList(http.Client());
  }


  @override
  Widget build(BuildContext context) {
    var candidateProvider = Provider.of<CandidateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringUtils.candidateListText),
      ),
      body: Column(

        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Text(
                  StringUtils.candidateNameText,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: kTitleTextBlackStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Text(
                  StringUtils.examNameText,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: kTitleTextBlackStyle,
                ),
              ),
            ],
          ),

          candidateProvider.isLoading?Loader():Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(

              border: TableBorder.all(
               color: Colors.grey
              ),
              children: List.generate(candidateProvider.candidateList.length, (index) {
                bool isEven = index % 2 == 0;
                return TableRow(
                  decoration: BoxDecoration(
                    color: isEven? Colors.blue.withAlpha(0x11): Colors.white.withAlpha(0x11),
                  ),
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15,left: 5),
                    child: Text(
                      "${index + 1}. ${candidateProvider.candidateList[index].candidateName}",
                      textAlign: TextAlign.start,
                      softWrap: true,
                      style: kTitleTextBlackStyle,
                    ),
                  ),
                  InkWell(
                    onTap: (){
//                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ProceedScreen(candidateModel: candidateProvider.candidateList[index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      child: Text(
                        candidateProvider.candidateList[index].examName,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: kTitleTextBlackStyle.apply(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ]);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
