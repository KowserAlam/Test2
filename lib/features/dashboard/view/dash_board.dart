import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p7app/features/auth/view/login_screen.dart';
import 'package:p7app/features/dashboard/view/widgets/info_box_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/job_chart_widget.dart';
import 'package:p7app/features/dashboard/view/widgets/profile_complete_parcent_indicatior_widget.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/messaging/view/message_screen.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/auth_service/auth_service.dart';
import 'package:p7app/main_app/failure/app_error.dart';
import 'package:p7app/main_app/p7_app.dart';
import 'package:p7app/main_app/resource/strings_utils.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/main_app/widgets/app_drawer.dart';
import 'package:p7app/main_app/widgets/failure_widget.dart';
import 'package:p7app/main_app/widgets/restart_widget.dart';
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
      Provider.of<UserProfileViewModel>(context, listen: false).getUserData();
    });


  }

  Future<void> _refreshData() async {
    var dbVM = Provider.of<DashboardViewModel>(context, listen: false);
    var upVM = Provider.of<UserProfileViewModel>(context, listen: false);
    return Future.wait([dbVM.getDashboardData(), upVM.getUserData()]);
  }

  _signOut(context) {

    AuthService.getInstance().then((value) => value.removeUser()).then((value){
      RestartWidget.restartApp(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var dashboardViewModel = Provider.of<DashboardViewModel>(context);

    errorWidget() {
      switch (dashboardViewModel.infoBoxError) {
        case AppError.serverError:
          return FailureFullScreenWidget(
            errorMessage: StringUtils.unableToLoadData,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.networkError:
          return FailureFullScreenWidget(
            errorMessage: StringUtils.unableToReachServerMessage,
            onTap: () {
              return _refreshData();
            },
          );

        case AppError.unauthorized:
          return FailureFullScreenWidget(
            errorMessage: StringUtils.unauthorizedText,
            onTap: () {
              return _signOut(context);
            },
          );

        default:
          return FailureFullScreenWidget(
            errorMessage: StringUtils.somethingIsWrong,
            onTap: () {
              return _refreshData();
            },
          );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.dashBoardText),
        actions: [
//          IconButton(
//            icon: Icon(FontAwesomeIcons.solidComment),
//            onPressed: () {
//              Navigator.of(context).push(CupertinoPageRoute(
//                  builder: (BuildContext context) => MessageScreen()));
//            },
//          )
        ],
      ),
      drawer: AppDrawer(
        routeName: 'dashboard',
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: dashboardViewModel.shouldShowError
            ? ListView(
                children: [
                  errorWidget(),
                ],
              )
            : ListView(
                children: [
                  ProfileCompletePercentIndicatorWidget(
                      dashboardViewModel.profileCompletePercent / 100),
                  InfoBoxWidget(
                    onTapApplied: widget.onTapApplied,
                    onTapFavourite: widget.onTapFavourite,
                  ),
                  JobChartWidget(
                    animate: true,
                  ),
                ],
              ),
      ),
    );
  }
}
