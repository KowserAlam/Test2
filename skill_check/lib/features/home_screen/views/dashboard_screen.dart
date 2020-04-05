import 'package:after_layout/after_layout.dart';
import 'package:skill_check/features/user_profile/profile_screen.dart';
import 'package:skill_check/main_app/auth_service/auth_user_model.dart';
import 'package:skill_check/features/home_screen/providers/dashboard_screen_provider.dart';
import 'package:skill_check/features/home_screen/views/widgets/featured_exams_dash_board_widget.dart';
import 'package:skill_check/features/home_screen/views/widgets/fail_to_load_data_error_widget.dart';
import 'package:skill_check/features/home_screen/views/widgets/enrolled_n_recent_exam_dashboard_widgets.dart';
import 'package:skill_check/main_app/flavour/flavor_banner.dart';
import 'package:skill_check/main_app/view/drawer.dart';
import 'package:skill_check/main_app/util/const.dart';
import 'package:skill_check/main_app/util/strings_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  final AuthUserModel authUser;

  DashBoardScreen({this.authUser});

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with AfterLayoutMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    var homeScreenProvider = Provider.of<DashboardScreenProvider>(context,listen: false);

    homeScreenProvider.fetchHomeScreenData();
  }

  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.width > 720;

    return WillPopScope(
      onWillPop: () async{
        if(_scaffoldKey.currentState.isDrawerOpen){
          return true;
        }else{
          return _exitApp(context);
        }

      } ,
      child: FlavorBanner(
        child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: AppDrawer(),
            ),
            appBar: AppBar(
              title: Text(StringUtils.appName),
              actions: <Widget>[
                Center(
                  child: Consumer<DashboardScreenProvider>(
                      builder: (context, dashboardScreenProvider, child) {
                    return Text(
                      dashboardScreenProvider.dashBoardData != null
                          ? "${dashboardScreenProvider.dashBoardData.user.name}"
                          : "",
                      overflow: TextOverflow.ellipsis,

                    );
                  }),
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                    Navigator.push(
                        _scaffoldKey.currentContext,
                        CupertinoPageRoute(
                            builder: (context) => ProfileScreen()));},
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      height: isLarge ? 35 : 28,
                      width: isLarge ? 35 : 28,
                      child: ClipRRect(
                        child: Consumer<DashboardScreenProvider>(
                            builder: (context, dashboardScreenProvider, child) {
                          return FadeInImage(
                            placeholder: AssetImage(kDefaultUserImageAsset),
                            image: NetworkImage(
                              dashboardScreenProvider.dashBoardData != null
                                  ? dashboardScreenProvider
                                      .dashBoardData.user.profilePicUrl
                                  : kDefaultUserImageNetwork,
                            ),
                            fit: BoxFit.cover,
                          );
                        }),
                        borderRadius:  BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () => Provider.of<DashboardScreenProvider>(context,listen: false)
                  .fetchHomeScreenData(),
              child: Consumer<DashboardScreenProvider>(
                  builder: (context, dashboardScreenProvider, child) {
                if (dashboardScreenProvider.isFailedToLoad) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 6),
                    child: FailToLoadDataErrorWidget(

                        onTap: () {
                      dashboardScreenProvider.fetchHomeScreenData();
                    }),
                  );
                }
                return ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  children: <Widget>[
                    EnrolledNRecentExamsDashBoardWidget(),

                    Divider(height: 16,),
                    SizedBox(height: 8,),
                    FeaturedExamsDashBoardWidget(),
                    SizedBox(height: 20),
                  ],
                );
              }),
            )),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: new Text(StringUtils.doYouWantToExitApp),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text(
                    'No',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text(
                    'Yes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
