
import 'package:assessment_ishraak/main_app/repositories/app_info_repository.dart';
import 'package:assessment_ishraak/main_app/util/strings_utils.dart';
import 'package:flutter/material.dart';

class AppVersionWidgetSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: AppInfoRepository().getAppVersion(),
        builder: (c,snapshot){
          if(snapshot.hasData){
            return Text("${StringUtils.versionText}: ${snapshot.data}",style: TextStyle(color: Colors.grey),);
          }
          return SizedBox();
        },
      ),
    );
  }
}
