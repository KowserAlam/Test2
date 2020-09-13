import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/job/models/job_model.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/logger_helper.dart';
import 'package:social_share/social_share.dart';

class ShareJobOnSocialMediaWidget extends StatelessWidget {
  final JobModel jobModel;

  ShareJobOnSocialMediaWidget(this.jobModel,{Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: StringResources.shareText,
      icon: Icon(Icons.share),
      onPressed: () async{
//          var res = await SocialShare.checkInstalledAppsForShare();
//          logger.i(res);
        var link = "${FlavorConfig.instance.values.baseUrl}/job-detail/${jobModel.slug}/";
        SocialShare.shareOptions("${jobModel.title}\n ${link}");
      },
    );
  }


}
