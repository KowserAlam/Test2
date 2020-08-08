import 'package:google_fonts/google_fonts.dart';
import 'package:p7app/features/auth/view_models/password_change_view_model.dart';
import 'package:p7app/features/auth/view_models/password_reset_view_model.dart';
import 'package:p7app/features/auth/view_models/sign_in_view_model.dart';
import 'package:p7app/features/auth/view_models/signup_viewmodel.dart';
import 'package:p7app/features/career_advice/view_models/career_advice_view_model.dart';
import 'package:p7app/features/company/view_model/company_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:p7app/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:p7app/features/job/view_model/applied_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/favourite_job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_filter_widget_view_model.dart';
import 'package:p7app/features/job/view_model/job_list_view_model.dart';
import 'package:p7app/features/job/view_model/job_screen_view_model.dart';
import 'package:p7app/features/messaging/view_mpdel/message_screen_view_model.dart';
import 'package:p7app/features/notification/view_models/notificaion_view_model.dart';
import 'package:p7app/features/settings/settings_view_model.dart';
import 'package:p7app/main_app/flavour/flavour_config.dart';
import 'package:p7app/main_app/util/common_serviec_rule.dart';
import 'package:p7app/main_app/util/locator.dart';
import 'package:p7app/main_app/views/widgets/restart_widget.dart';
import 'package:provider/provider.dart';
import 'package:p7app/main_app/root.dart';
import 'package:p7app/features/user_profile/view_models/user_profile_view_model.dart';
import 'package:p7app/main_app/app_theme/app_theme.dart';
import 'package:p7app/main_app/resource/strings_resource.dart';
import 'package:bot_toast/bot_toast.dart';

class P7App extends StatelessWidget {
  final isEnabledDevicePreview;
  final CommonServiceRule commonServiceRule = CommonServiceRule();

  P7App({this.isEnabledDevicePreview = false});

  @override
  Widget build(BuildContext context) {
    var providers = [
      ChangeNotifierProvider(create: (context) => SignInViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(create: (context) => JobListViewModel()),
      ChangeNotifierProvider(create: (context) => AppliedJobListViewModel()),
      ChangeNotifierProvider(create: (context) => FavouriteJobListViewModel()),
      ChangeNotifierProvider(create: (context) => CompanyListViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordResetViewModel()),
      ChangeNotifierProvider(create: (context) => UserProfileViewModel()),
      ChangeNotifierProvider(create: (context) => SignUpViewModel()),
      ChangeNotifierProvider(
          create: (context) => JobListFilterWidgetViewModel()),
      ChangeNotifierProvider(create: (context) => PasswordChangeViewModel()),
      ChangeNotifierProvider(create: (context) => DashboardViewModel()),
      ChangeNotifierProvider(create: (context) => CareerAdviceViewModel()),
      ChangeNotifierProvider(create: (context) => locator<SettingsViewModel>()),
      ChangeNotifierProvider(create: (context) => NotificationViewModel()),
      ChangeNotifierProvider(create: (context) => MessageScreenViewModel()),
      ChangeNotifierProvider(create: (context) => JobScreenViewModel()),
    ];
    var appName = FlavorConfig.appName();

    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        builder: BotToastInit(),
        debugShowCheckedModeBanner: false,
        title: appName,
        theme: AppTheme.lightTheme.copyWith(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
//      darkTheme: AppTheme.darkTheme,
        home: Root(),
      ),
    );
  }
}
