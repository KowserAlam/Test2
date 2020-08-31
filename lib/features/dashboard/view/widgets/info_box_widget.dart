import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/views/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class InfoBoxWidget extends StatelessWidget {
  final Function onTapFavourite;
  final Function onTapApplied;

  InfoBoxWidget({this.onTapFavourite, this.onTapApplied});

  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);
    var infoBoxData = Provider.of<DashboardViewModel>(context).infoBoxData;
    return dashboardViewModel.shouldShowInfoBoxLoader
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: true,
                    child: Row(
                      children: [
                        Expanded(
                            child: _boxItem(
                                linearGradient: LinearGradient(colors: [
                          Color(0xff91bcf9),
                          Color(0xff99d7f2),
                        ]))),
                        Expanded(
                            child: _boxItem(
                                linearGradient: LinearGradient(colors: [
                          Color(0xff91bcf9),
                          Color(0xff99d7f2),
                        ]))),
                        Expanded(
                            child: _boxItem(
                                linearGradient: LinearGradient(colors: [
                          Color(0xff91bcf9),
                          Color(0xff99d7f2),
                        ]))),
                      ],
                    ))),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    /// Skill
                    Expanded(
                      child: _boxItem(
                          linearGradient: LinearGradient(colors: [
                            Color(0xffaa91fa),
                            Color(0xff9eacfd),
                          ]),
                          iconData: FontAwesomeIcons.tools,
                          label: StringResources.skillsText,
                          key: Key('dashboardSkillInfoBox'),
                          count: infoBoxData?.skillsCount ?? 0),
                    ),

                    /// applied
                    Expanded(
                      child:

                          /// applied
                          _boxItem(
                              linearGradient: LinearGradient(colors: [
                                Color(0xffffb87b),
                                Color(0xffe1b8fe),
                              ]),
                              iconData: FontAwesomeIcons.solidCheckSquare,
                              label: StringResources.appliedText,
                              key: Key('dashboardAppliedInfoBox'),
                              onTap: onTapApplied,
                              count: infoBoxData?.appliedJobCount),
                    ),

                    /// favorite
                    Expanded(
                      child: _boxItem(
                          linearGradient: LinearGradient(colors: [
                            Color(0xff91bcf9),
                            Color(0xff99d7f2),
                          ]),
                          iconData: FontAwesomeIcons.solidHeart,
                          label: StringResources.favoriteText,
                          key: Key('dashboardFavoriteInfoBox'),
                          count: infoBoxData?.favouriteJobCount,
                          onTap: onTapFavourite),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  _boxItem({
    String label,
    int count,
    IconData iconData,
    LinearGradient linearGradient,
    Function onTap,
    Key key,
  }) {
    return LayoutBuilder(builder: (context, constrain) {
      var screenHeight = MediaQuery.of(context).size.height;
      var deviceWidth = MediaQuery.of(context).size.width;
      double iconSize = deviceWidth * .083;
      double numberFontSize = iconSize / 1.6;
      double textFontSize = iconSize / 3;
      double boxHeight = iconSize * (1.2+(screenHeight* .002));
      return Container(
        key: key,
        margin: EdgeInsets.all(4),
        height: boxHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), gradient: linearGradient),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (iconData != null)
                    Icon(
                      iconData,
                      color: Colors.white,
                      size: iconSize,
                    ),
                  SizedBox(width: 5),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
//                if(count!= null)
                      Text(
                        "${count ?? "0"}",
                        style: TextStyle(
                            color: Colors.white, fontSize: numberFontSize),
                      ),
                      Text(
                        label ?? "",
                        style: TextStyle(
                            color: Colors.white, fontSize: textFontSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
