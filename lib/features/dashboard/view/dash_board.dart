import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:p7app/features/auth/view/sign_in_screen.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/features/dashboard/view/widgets/career_advice_list_h_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/dashboard_header.dart';
import 'package:p7app/features/dashboard/view/widgets/fretured_companies_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/home_screen_signin_message_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/other_screens_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/profile_complete_parcent_indicatior_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/recent_jobs_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/vital_state_widget.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/notification/views/notification_screen.dart';
import 'package:p7app/features/settings/setings_screen.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  final Function onTapFavourite;
  final Function onTapApplied;
  final Function onTapSearch;
  final Function onTapRecentJobs;
  final Function onTapFeaturedCompany;

  DashBoard(
      {Key key,
      this.onTapFavourite,
      this.onTapApplied,
      this.onTapSearch,
      this.onTapRecentJobs,
      this.onTapFeaturedCompany})
      : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>  {
  final List<String> menuItems = [
    "Settings",
    "Sign Out",
  ];
  DashboardViewModel dashboardViewModel;

  @override
  void initState() {

    Get.put(DashboardViewModel());
     dashboardViewModel = Get.find<DashboardViewModel>();
    dashboardViewModel
        .getDashboardData()
        .then((value) {
      if (value == AppError.unauthorized) {
        _signOut(context);
        return;
      }
//      Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
    });
    super.initState();
  }


  Future<void> _refreshData() async {

    var upVM = Provider.of<UserProfileViewModel>(context, listen: false);
    var cvm = Provider.of<CareerAdviceViewModel>(context, listen: false);
    var isLoggedIn =
        Provider.of<AuthViewModel>(context, listen: false).isLoggerIn;
    return Future.wait([
      dashboardViewModel.getDashboardData(),
      if (isLoggedIn) upVM.getUserData(),
      cvm.refresh(),
    ]);
  }

  _signOut(context) {
    locator<SettingsViewModel>().signOut();
  }

  @override
  Widget build(BuildContext context) {

    var authVM = Provider.of<AuthViewModel>(context);
    bool isLoggedIn = authVM.isLoggerIn;

    var notificationIcon = Obx(() {
      NotificationViewModel c = Get.find();

      bool hastUnreadNoti = c.hasUnreadNotification;
      return Stack(
        children: [
          Center(
            child: IconButton(
              key: Key("dashboardNotificationIcon"),
              iconSize: 15,
              tooltip: StringResources.notificationsText,
              icon: Icon(FontAwesomeIcons.solidBell),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => NotificationScreen()));
              },
            ),
          ),
          // if (hastUnreadNoti)
          //   Positioned(
          //       right: 8,
          //       top: 18,
          //       child: Container(
          //         height: 10,
          //         width: 10,
          //         decoration: BoxDecoration(
          //             color: Colors.red,
          //             borderRadius: BorderRadius.circular(5)),
          //       )),
        ],
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringResources.homText,
          key: Key('dashboardAppbarTitle'),
        ),
        actions: [
          if (isLoggedIn) notificationIcon,
          if (isLoggedIn)
            PopupMenuButton<String>(
              key: Key("dashboardPopupMenuKey"),
              onSelected: (v) {
                switch (v) {
                  case "Settings":
                    {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return SettingsScreen();
                      }));
                      break;
                    }
                  case "Sign Out":
                    {
                      locator<SettingsViewModel>().signOut();
                      break;
                    }
                }
              },
              icon: Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              itemBuilder: (BuildContext context) =>
                  List.generate(menuItems.length, (index) {
                return PopupMenuItem(
                  value: menuItems[index],
                  key: Key(menuItems[index]),
                  child: Text(menuItems[index]),
                );
              }),
            ),
          if (!isLoggedIn)
            Center(
                key: Key("dashboardLoginButtonKey"),
                child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => SignInScreen()));
              },
              child: Text(StringResources.signInButtonText),
            ))
        ],
      ),
//      drawer: AppDrawer(
//        routeName: 'dashboard',
//      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child:
//        dashboardViewModel.shouldShowError ?ListView(children: [errorWidget()]) :
            ListView(
              key: Key('dashboardListview'),
          children: [
            if (!isLoggedIn)
              DashboardHeader(
                onTapSearch: widget.onTapSearch,
                key: Key('onTapSearch'),
              ),
            if (isLoggedIn)
              Column(
                children: [
                  GetBuilder<DashboardViewModel>(
                    builder: (vm) {
                      return  vm
                          .showProfileCompletePercentIndicatorWidget?
                        ProfileCompletePercentIndicatorWidget(
                            vm.profileCompletePercent / 100):SizedBox();
                    }
                  ),
                  InfoBoxWidget(
                    onTapApplied: widget.onTapApplied,
                    onTapFavourite: widget.onTapFavourite,
                  ),
                  JobChartWidget(),
                ],
              ),
            if (!isLoggedIn) HomeScreenSigninMessageWidget(),
            SizedBox(height: 10),
            FeaturedCompaniesWidget(onTapViewAll: widget.onTapFeaturedCompany),
            RecentJobs(onTapViewAll: widget.onTapRecentJobs),
            // TopCategoriesWidget(),
            SizedBox(height: 10),
            VitalStateWidget(),
            SizedBox(height: 10),
            // SizedBox(height: 10),
            CareerAdviceListHWidget(),
            // SizedBox(height: 5),
            OtherScreensWidget(),
          ],
        ),
      ),
    );
  }
}
