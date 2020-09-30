import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p7app/features/auth/view_models/password_change_view_model.dart';
import 'package:p7app/features/auth/view_models/password_reset_view_model.dart';
import 'package:p7app/features/auth/view_models/sign_in_view_model.dart';
import 'package:p7app/features/auth/view_models/signup_viewmodel.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/features/company/view_model/company_list_view_model.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/view_model/all_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:p7app/features/messaging/view_mpdel/message_sender_list_screen_view_model.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/auth_service/auth_view_model.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:provider/provider.dart';

class P7App extends StatelessWidget {
  final isEnabledDevicePreview;
  final CommonServiceRule commonServiceRule = CommonServiceRule();
  FirebaseAnalytics analytics = FirebaseAnalytics();

  P7App({this.isEnabledDevicePreview = false});


  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    var locators = [
      ChangeNotifierProvider(create: (context) => locator<SettingsViewModel>()),
      ChangeNotifierProvider(create: (context) => locator<AuthViewModel>()),
    ];

    var providers = [
      ChangeNotifierProvider(create: (context) => SignInViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => AllJobListViewModel()),
      ChangeNotifierProvider(create: (context) => CompanyListViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => UserProfileViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(
          create: (context) => JobListFilterWidgetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
      ChangeNotifierProvider(create: (context) => DashboardViewModel()),
      ChangeNotifierProvider(create: (context) => CareerAdviceViewModel()),
      ChangeNotifierProvider(
          create: (context) => MessageSenderListScreenViewModel()),
      ChangeNotifierProvider(create: (context) => JobScreenViewModel()),
    ];
    var appName = FlavorConfig.appName();


    Get.config(
      enableLog: true,
      defaultPopGesture: true,
      defaultTransition: Transition.cupertino,
      defaultOpaqueRoute: true,
      defaultDurationTransition: Duration(milliseconds: 180),
    );
    return MultiProvider(

      providers: locators,
      child: Consumer<AuthViewModel>(
        builder: (context,vm,child){
          return MultiProvider(
            key: Key(vm.user?.userId??""),
            providers: providers,
            child: GetMaterialApp(
              navigatorKey: navigatorKey,
              navigatorObservers: [
                BotToastNavigatorObserver(),
                FirebaseAnalyticsObserver(analytics: analytics),
              ],
              builder: BotToastInit(),
              debugShowCheckedModeBanner: false,
              title: appName,
              theme: AppTheme.lightTheme.copyWith(
                textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
              ),
              home: Root(),
            ),
          );
        },
      ),
    );
  }
}
