import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/features/dashboard/view/widgets/career_advice_list_h_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/other_screens_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/profile_complete_parcent_indicatior_widget.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/notification/views/notification_screen.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/failure_widget.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  final Function onTapFavourite;
  final Function onTapApplied;

  DashBoard({Key key, this.onTapFavourite, this.onTapApplied})
      : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with AfterLayoutMixin {
  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<DashboardViewModel>(context, listen: false)
        .getDashboardData(isFormOnPageLoad: true)
        .then((value) {
      if (value == AppError.unauthorized) {
        _signOut(context);
        return;
      }
//      Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
    });
  }

  Future<void> _refreshData() async {
    var dbVM = Provider.of<DashboardViewModel>(context, listen: false);
    var upVM = Provider.of<UserProfileViewModel>(context, listen: false);
    var cvm = Provider.of<CareerAdviceViewModel>(context, listen: false);
    return Future.wait([dbVM.getDashboardData(), upVM.getUserData(),cvm.refresh()]);
  }

  _signOut(context) {
    locator<SettingsViewModel>().signOut();
  }

  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);

    errorWidget() {
      switch (dashboardViewModel.infoBoxError) {
        case AppError.serverError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unableToLoadData,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.networkError:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unableToReachServerMessage,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.unauthorized:
          return FailureFullScreenWidget(
            errorMessage: StringResources.unauthorizedText,
            onTap: () {
              return _signOut(context);
            },
          );

        default:
          return FailureFullScreenWidget(
            errorMessage: StringResources.somethingIsWrong,
            onTap: () {
              return _refreshData();
            },
          );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(StringResources.dashBoardText),
        actions: [
//          IconButton(
//            key: Key("dashboardNotificationIcon"),
//            iconSize: 15,
//            tooltip: StringResources.notificationsText,
//            icon: Icon(FontAwesomeIcons.solidBell),
//            onPressed: () {
//              Navigator.of(context).push(CupertinoPageRoute(
//                  builder: (BuildContext context) => NotificationScreen()));
//            },
//          )
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
            if(dashboardViewModel.showProfileCompletePercentIndicatorWidget)
            ProfileCompletePercentIndicatorWidget(
                dashboardViewModel.profileCompletePercent / 100),
            InfoBoxWidget(
              onTapApplied: widget.onTapApplied,
              onTapFavourite: widget.onTapFavourite,
            ),
            JobChartWidget(
            ),
//            TopCategoriesWidget(),
//            VitalStateWidget(),
            SizedBox(height: 10,),
            CareerAdviceListHWidget(),
            SizedBox(height: 10,),
            OtherScreensWidget(),


          ],
        ),
      ),
    );
  }
}


