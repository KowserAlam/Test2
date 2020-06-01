import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class InfoBoxWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);
    var infoBoxData = Provider.of<DashboardViewModel>(context).infoBoxData;
    return dashboardViewModel.shouldShowInfoBoxLoader
        ? Container( height: 100,child: Loader())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                /// Skill

                _boxItem(
                    linearGradient: LinearGradient(colors: [
                      Color(0xffaa91fa),
                      Color(0xff9eacfd),
                    ]),
                    iconData: FeatherIcons.feather,
                    label: StringUtils.skillsText,
                    count: infoBoxData?.skillsCount??0),

                Row(
                  children: [
                    /// applied
                    Expanded(
                      child:
                      /// applied
                      _boxItem(
                          linearGradient: LinearGradient(colors: [
                            Color(0xffffb87b),
                            Color(0xffe1b8fe),
                          ]),
                          iconData: FeatherIcons.briefcase,
                          label: StringUtils.appliedText,
                          count: infoBoxData?.appliedJobCount),
                    ),
                    /// favorite
                    Expanded(
                      child: _boxItem(
                          linearGradient: LinearGradient(colors: [
                            Color(0xff91bcf9),
                            Color(0xff99d7f2),
                          ]),
                          iconData: FeatherIcons.heart,
                          label: StringUtils.favoriteText,
                          count: infoBoxData?.favouriteJobCount),
                    ),

                  ],
                ),
              ],
            ),
          );
  }

  _boxItem(
      {String label,
      int count,
      IconData iconData,
      LinearGradient linearGradient}) {
    return Container(
      margin: EdgeInsets.all(4),
      height: 100,
//      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), gradient: linearGradient),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$count",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
