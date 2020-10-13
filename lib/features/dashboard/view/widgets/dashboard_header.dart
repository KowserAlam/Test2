import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_text_field.dart';

class DashboardHeader extends StatelessWidget {
  final Function onTapSearch;

  DashboardHeader({this.onTapSearch, Key key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xff1F3245),
        image: DecorationImage(
          image: AssetImage(kUserProfileCoverImageAsset),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringResources.allTheGreatJobsInOnePlace,
              key: Key('allTheGreatJobsInOnePlaceKey'),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              StringResources.findJobsEmploymentText,
              key: Key('findJobsEmploymentTextKey'),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                readOnly: true,
                onTap: onTapSearch,
                hintText: "Search",
                textFieldKey: Key('homeOnTapSearchPushToAllJobsKey'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
