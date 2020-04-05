import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:skill_check/features/assessment/providers/exam_provider.dart';
import 'package:skill_check/features/assessment/providers/submit_provider.dart';
import 'package:skill_check/features/home_screen/views/dashboard_screen.dart';
import 'package:skill_check/main_app/auth_service/auth_user_model.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:skill_check/main_app/util/json_keys.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {


    try{
      /// Disable screen off
      Wakelock.disable();
    }catch (e){
      print(e);
    }


    /// reset state of exam provider
    Provider.of<ExamProvider>(context,listen: false).resetState();

    Provider.of<DashboardScreenProvider>(context,listen: false).fetchHomeScreenData();
  }

  @override
  Widget build(BuildContext context) {
    var submitProvider = Provider.of<SubmitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.resultText),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: submitProvider.resultData == null
              ? Center(
                  child: Text(StringUtils.pleaseWaitText),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You have ${submitProvider.resultData.correctAns} correct  out of ${submitProvider.resultData.numberOfQuestion}",
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
                          submitProvider.resultData.percentageOfRightAns / 100,
                      startAngle: 180,
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Colors.red[400],
                      center: Text(
                        "${submitProvider.resultData.percentageOfRightAns.round()}%",
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      progressColor: Colors.green[600],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=>DashBoardScreen()),(_)=>false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                         mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios),
                            Text(
                              StringUtils.backText,
                              style: Theme.of(context).textTheme.title,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
