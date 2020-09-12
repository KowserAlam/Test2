import 'package:flutter/material.dart';
import 'package:p7app/main_app/resource/const.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/custom_text_field.dart';

class DashboardHeader extends StatelessWidget {
  final Function onTapSearch;

  DashboardHeader({this.onTapSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
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
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              StringResources.findJobsEmploymentText,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
